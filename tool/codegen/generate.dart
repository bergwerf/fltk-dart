// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:io';

import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';
import 'package:mustache/mustache.dart';

/// Important notes:
///
/// - In the input files no Dart types nor C types are used. Instead there is
///   a mixed approach where some types are described using their Dart name
///   (like String) and some using their C++/FLTK type (like Fl_Font).
///   Don't ask why, it's a mess, but it works.

/// Path from the repository root to this directory
const root = 'tool/codegen';

/// Relative path for custom method source files from the current directory.
const customSources = 'ext/src/custom';

/// Relative path for custom method source files from the gen directory.
const customSourcesRelative = '../../custom';

/// All class input files.
final classFiles = new Glob("ext/classes/*.yaml");

/// All functions input files.
final funcsFiles = new Glob("ext/functions/*.yaml");

/// Arguments placeholder for custom methods.
const customMethod = '[custom]';

final functionRegex = new RegExp(r'([A-z_0-9]*)\s([A-z_0-9:->]*)');
final methodRegex = new RegExp(r'([A-z_0-9]*)\s([A-z_0-9]*)\((.*)\)');
final argRegex = new RegExp(r'\s*([A-z_0-9*]+)\s+([A-z_0-9]*)');

/// Types that do not have to be casted.
const List<String> noCastTypes = const ['int', 'double', 'bool'];

/// Dart API functions for converting the given C types to a Dart_Handle.
const Map<String, String> toDartHandle = const {
  'int64_t': 'Dart_NewInteger',
  'double': 'Dart_NewDouble',
  'bool': 'Dart_NewBoolean',
  'const char*': 'Dart_NewStringFromCString'
};

/// Dart API functions to generate the given C values from a Dart_Handle.
const Map<String, String> dartToCTypeConv = const {
  'int64_t': 'Dart_IntegerToInt64',
  'double': 'Dart_DoubleValue',
  'bool': 'Dart_BooleanValue',
  'const char*': 'Dart_StringToCString',
  'intptr_t': 'Dart_GetNativeInstanceField'
};

/// Type name C equivalents
const Map<String, String> typeToCType = const {
  'void': 'void',
  'int': 'int64_t',
  'double': 'double',
  'bool': 'bool',
  'String': 'const char*'
};

/// Load settings.
final settings = loadYaml(new File('$root/settings.yaml').readAsStringSync());

/// TODO: use implicit cast with settings.yaml
int main(List<String> args) {
  // Load templates.
  var classHeaderTemplate = new Template(
      new File('$root/templates/classes/header.mustache').readAsStringSync(),
      lenient: true);
  var classSourceTemplate = new Template(
      new File('$root/templates/classes/source.mustache').readAsStringSync(),
      lenient: true);
  var wrapperHeaderTemplate = new Template(
      new File('$root/templates/wrappers/header.mustache').readAsStringSync(),
      lenient: true);
  var wrapperSourceTemplate = new Template(
      new File('$root/templates/wrappers/source.mustache').readAsStringSync(),
      lenient: true);
  var funcsHeaderTemplate = new Template(
      new File('$root/templates/functions/header.mustache').readAsStringSync(),
      lenient: true);
  var funcsSourceTemplate = new Template(
      new File('$root/templates/functions/source.mustache').readAsStringSync(),
      lenient: true);

  // Process class files.
  for (var file in classFiles.listSync()) {
    processClassFile(
        file,
        'ext/src/gen/classes',
        'ext/src/gen/wrappers',
        classHeaderTemplate,
        classSourceTemplate,
        wrapperHeaderTemplate,
        wrapperSourceTemplate);
  }

  // Process function files.
  for (var file in funcsFiles.listSync()) {
    processFuncsFile(
        file, 'ext/src/gen/funcs', funcsHeaderTemplate, funcsSourceTemplate);
  }

  return 0;
}

/// Process a YAML file with a class definition.
void processClassFile(
    File file,
    String dir,
    String wrapperDir,
    Template headerTemplate,
    Template sourceTemplate,
    Template wrapperHeaderTemplate,
    Template wrapperSourceTemplate) {
  var content = loadYaml(file.readAsStringSync());
  var dartname = content['dartname'];

  // Should we generate a wrapper to redirect base methods?
  var createWrapper = !(content['wrapper'] == false);

  // Parse constructors.
  var constructors = [];
  content['constructors'].forEach((String constructor) {
    constructors.add(parseMethod(constructor, true, createWrapper));
  });

  // Parse methods.
  var methods = [];
  content['methods'].forEach((String method) {
    methods.add(parseMethod(method, false));
  });

  // Generate new mustache input data.
  var mustacheData = {
    'header': 'FLDART_${content['dartname'].toUpperCase()}_H',
    'cname': content['cname'],
    'dartname': dartname,

    // Class that is used for construction and method calling
    'targetClass':
        createWrapper ? '${content['cname']}_Wrapper' : content['cname'],

    // #include string for the class header
    'targetClassInclude': createWrapper
        ? '"../wrappers/${content['cname']}_Wrapper.hpp"'
        : '<FL/${content['cname']}.H>',

    'constructors': constructors,
    'methods': methods,

    // Use separate methodNames for FunctionMapping to support custom classes
    // (custom methods are removed from the methods list when generating the
    // class source).
    'methodNames':
        new List<String>.generate(methods.length, (int i) => methods[i]['name'])
  };

  // Add custom source include.
  if (new File('$customSources/$dartname.cpp').existsSync()) {
    mustacheData['sourceInclude'] = ['$customSourcesRelative/$dartname.cpp'];
  }

  // Write header.
  new File('$dir/${content['dartname']}.hpp')
      .writeAsStringSync(headerTemplate.renderString(mustacheData));

  // Remove all custom methods.
  for (var i = 0; i < mustacheData['methods'].length; i++) {
    if (mustacheData['methods'][i].containsKey('custom')) {
      mustacheData['methods'].removeAt(i);
      i--;
    }
  }

  // Write source.
  new File('$dir/${content['dartname']}.cpp')
      .writeAsStringSync(sourceTemplate.renderString(mustacheData));

  if (createWrapper) {
    // Generate data for wrapper class
    //
    // Datastructure:
    // header: HPP #define header
    // class: C++ class name
    // constructors:
    // - argslist: comma separated list of arguments
    //   argsdef: comma separated list of arguments with types
    var wrapperconstructors = [];
    constructors.forEach((Map<String, dynamic> data) {
      var args = [];
      data['args'].forEach((Map<String, dynamic> arg) {
        args.add(arg['name']);
      });
      wrapperconstructors.add({
        'argslist': args.join(','),
        'argsdef': data['argsdef'].replaceAll('String', 'const char*')
      });
    });

    var wrapperData = {
      'header': 'FLDART_${content['cname'].toUpperCase()}_WRAPPER_H',
      'class': content['cname'],
      'constructors': wrapperconstructors,
      'drawcb': settings['drawcb'].contains(content['cname']) ? [1] : []
    };

    // Write wrapper files.
    new File('$wrapperDir/${content['cname']}_Wrapper.hpp')
        .writeAsStringSync(wrapperHeaderTemplate.renderString(wrapperData));
    new File('$wrapperDir/${content['cname']}_Wrapper.cpp')
        .writeAsStringSync(wrapperSourceTemplate.renderString(wrapperData));
  }
}

/// Process a YAML file with function definitions.
void processFuncsFile(
    File file, String dir, Template headerTemplate, Template sourceTemplate) {
  var content = loadYaml(file.readAsStringSync());

  // Parse functions.
  var functions = [];
  content['functions'].forEach((YamlMap function) {
    functions.add(parseFunction(function));
  });

  // Generate new mustache input data.
  var mustacheData = {
    'header': 'FLDART_${content['name'].toUpperCase()}_H',
    'include': content['include'],
    'name': content['name'],
    'functions': functions
  };

  // Write output files.
  new File('$dir/${content['name']}.hpp')
      .writeAsStringSync(headerTemplate.renderString(mustacheData));
  new File('$dir/${content['name']}.cpp')
      .writeAsStringSync(sourceTemplate.renderString(mustacheData));
}

/// Parse a single function.
Map<String, dynamic> parseFunction(YamlMap function) {
  // We need the following fields:
  //
  // - name:    function name
  //   call:    how the function is called
  //   return:  how the return value is generated
  //   args:
  //   - argi: argument index
  //     name: argument variable name
  //     type: argument C++ type
  //     conv: Dart API function to convert this argument

  var match = functionRegex.firstMatch(function['code']);

  Map<String, dynamic> ret = {
    'name': function['name'],
    'return': codeForNewDartHandle(primitiveCType(match.group(1)), '_tmp')
  };

  var args = parseArguments(function['args']);
  ret['call'] = wrapCall(
      match.group(1), '${match.group(2)}(${args.list.join(',')})', '_tmp');
  ret['args'] = args.data;

  return ret;
}

/// Parse a single method.
///
/// Generates data that targets a wrapper class if [withWrapper] is true.
Map<String, dynamic> parseMethod(String method, bool constructor,
    [bool withWrapper = false]) {
  // We need the following fields:
  //
  // - name:      method name
  //   call:      how the method is called (used by real methods)
  //   argsdef:   comma separated list of arguments and types (used by wrapper constructors)
  //   argslist:  comma separated list of argument labels (used by constructors)
  //   return:    how the return value is generated (used by real methods)
  //   args:
  //   - argi: argument index
  //     name: argument variable name
  //     type: argument C++ type
  //     conv: Dart API function to convert this argument

  var match = methodRegex.firstMatch(method);

  Map<String, dynamic> ret = {
    'name': constructor ? match.group(2) : '${match.group(1)}_${match.group(2)}'
  };

  // If this is a custom method, do not parse the arguments or generate the
  // call/return code.
  if (match.group(3) == customMethod) {
    ret['custom'] = true;
  } else {
    // Generate return value generation code.
    ret['return'] =
        codeForNewDartHandle(primitiveCType(match.group(1)), '_tmp');

    // Parse arguments.
    var args = parseArguments(match.group(3), 1);
    var argslist = args.list.join(',');

    // Generate method call code.
    ret['call'] = wrapCall(
        match.group(1), '_ref -> ${match.group(2)}($argslist)', '_tmp');

    // Store arguments data.
    ret['argslist'] = constructor && withWrapper ? '_ref,$argslist' : argslist;
    ret['argsdef'] = match.group(3);
    ret['args'] = args.data;
  }

  return ret;
}

class Args {
  List<String> list = [];
  List<Map<String, dynamic>> data = [];
}

/// Parse a list of arguments into an [Args] instance.
Args parseArguments(String argstr, [int argiOffset = 0]) {
  var args = new Args();

  // Parse argument string
  if (argstr != null && argstr.isNotEmpty) {
    var list = argstr.split(',');
    for (var i = 0; i < list.length; i++) {
      var match = argRegex.firstMatch(list[i]);
      var primitiveType = primitiveCType(match.group(1));
      var argname = match.group(2);
      args.data.add({
        'argi': i + argiOffset,
        'name': argname,
        'type': primitiveType,

        // Convert from Dart_Handle to C type.
        'conv': dartToCTypeConv[primitiveType],

        'convargs': primitiveType == 'intptr_t' ? '0, &$argname' : '&$argname'
      });

      args.list.add(castToType(match.group(1), match.group(2), true, false));
    }
  }

  return args;
}

/// Convert type name to pure C type.
String primitiveCType(String type) {
  if (typeToCType.containsKey(type)) {
    return typeToCType[type];
  } else if (settings['enums'].contains(type)) {
    // Enumerations are stored as int64_t (Dart only uses int64_t)
    return 'int64_t';
  } else if (settings['typedefs'].keys.contains(type)) {
    // Return defined type.
    return settings['typedefs'][type];
  } else if (type.endsWith('*')) {
    // This is a pointer: store as intptr_t
    return 'intptr_t';
  } else {
    throw new ArgumentError('Type $type was not recognized.');
  }
}

/// Wrap function call [call] so that the return value of type [type] is casted
/// and stored in [dstvar].
String wrapCall(String type, String call, String dstvar) {
  if (type == 'void') {
    return call;
  } else {
    return '${primitiveCType(type)} $dstvar = ${castToType(type, call, false, true)}';
  }
}

/// Cast the output of [call] from the primitive C type of [type] to the
/// temporary type of [type] used for FLTK calls (or the other way around if
/// [reverse] is set). If [realloc] is set it will add reallocation code for
/// const char* to prevent issues.
String castToType(String type, String call, bool realloc, bool reverse) {
  if (noCastTypes.contains(type)) {
    return call;
  } else if (type == 'String') {
    // Copy into new string if we need a realloc.
    return realloc ? 'newstr($call)' : call;
  } else if (settings['enums'].contains(type)) {
    // Enumerations are static casted
    return 'static_cast<${reverse ? 'int64_t' : type}>($call)';
  } else if (settings['typedefs'].keys.contains(type)) {
    // Implicit cast to defined type.
    return '(${reverse ? settings['typedefs'][type] : type})$call';
  } else if (type.endsWith('*')) {
    // Pointers are implicitly casted
    return '(${reverse ? 'intptr_t' : type})$call';
  } else {
    // Assume this is an enumeration: do static_cast<>
    return 'static_cast<${reverse ? 'int64_t' : type}>($call)';
  }
}

/// Generate code for creating a new Dart_Handle from the given C [type] with
/// the [srcvar] as input variable.
String codeForNewDartHandle(String type, String srcvar) {
  if (toDartHandle.containsKey(type)) {
    return '${toDartHandle[type]}($srcvar)';
  } else {
    return 'Dart_Null()';
  }
}
