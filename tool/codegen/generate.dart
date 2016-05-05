// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:io';

import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';
import 'package:mustache/mustache.dart';

/// Path from the repository root to this folder
const root = 'tool/codegen';

/// All widget input files.
final widgetFiles = new Glob("ext/widgets/*.yaml");

/// All functions input files.
final funcsFiles = new Glob("ext/functions/*.yaml");

final functionRegex = new RegExp(r'([A-z_0-9]*)\s([A-z_0-9:->]*)');
final methodRegex = new RegExp(r'([A-z_0-9]*)\s([A-z_0-9]*)\((.*)\)');
final argRegex = new RegExp(r'\s*([A-z_0-9*]+)\s+([A-z_0-9]*)');

/// Types that do not have to be casted.
const List<String> noCastTypes = const ['int', 'double', 'bool'];

const Map<String, String> newDartHandle = const {
  'int64_t': 'Dart_NewInteger',
  'double': 'Dart_NewDouble',
  'bool': 'Dart_NewBoolean',
  'const char*': 'Dart_NewStringFromCString'
};

const Map<String, String> dartToCTypeConv = const {
  'int64_t': 'Dart_IntegerToInt64',
  'double': 'Dart_DoubleValue',
  'bool': 'Dart_BooleanValue',
  'const char*': 'Dart_StringToCString'
};

const Map<String, String> dartToCType = const {
  'void': 'void',
  'int': 'int64_t',
  'double': 'double',
  'bool': 'bool',
  'String': 'const char*'
};

int main(List<String> args) {
  // Load templates.
  var widgetHppTemplate = new Template(
      new File('$root/templates/widgets/hpp.mustache').readAsStringSync(),
      lenient: true);
  var widgetCppTemplate = new Template(
      new File('$root/templates/widgets/cpp.mustache').readAsStringSync(),
      lenient: true);
  var funcsHppTemplate = new Template(
      new File('$root/templates/functions/hpp.mustache').readAsStringSync(),
      lenient: true);
  var funcsCppTemplate = new Template(
      new File('$root/templates/functions/cpp.mustache').readAsStringSync(),
      lenient: true);

  // Process widget files.
  for (var file in widgetFiles.listSync()) {
    processWidgetFile(
        file, 'ext/src/widgets', widgetHppTemplate, widgetCppTemplate);
  }

  // Process function files.
  for (var file in funcsFiles.listSync()) {
    processFuncsFile(file, 'ext/src/core', funcsHppTemplate, funcsCppTemplate);
  }

  return 0;
}

/// Process a YAML file with a widget definition.
void processWidgetFile(File file, String dir, Template hpp, Template cpp) {
  var content = loadYaml(file.readAsStringSync());

  // Parse constuctors.
  var constructors = [];
  content['constructors'].forEach((String constructor) {
    constructors.add(parseMethod(constructor, true));
  });

  // Parse methods.
  var methods = [];
  content['methods'].forEach((String method) {
    methods.add(parseMethod(method, false));
  });

  // Generate new mustache input data.
  var mustacheData = {
    'header': 'FLDART_${content['dartname'].toUpperCase()}_H',
    'include': content['include'],
    'cname': content['cname'],
    'dartname': content['dartname'],
    'constructors': constructors,
    'methods': methods
  };

  // Write output files.
  new File('$dir/${content['dartname']}.hpp')
      .writeAsStringSync(hpp.renderString(mustacheData));
  new File('$dir/${content['dartname']}.cpp')
      .writeAsStringSync(cpp.renderString(mustacheData));
}

/// Process a YAML file with function definitions.
void processFuncsFile(File file, String dir, Template hpp, Template cpp) {
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
      .writeAsStringSync(hpp.renderString(mustacheData));
  new File('$dir/${content['name']}.cpp')
      .writeAsStringSync(cpp.renderString(mustacheData));
}

/// Parse a single function.
Map<String, dynamic> parseFunction(YamlMap function) {
  // We need the following fields:
  //
  // - name: method name
  //   call: how the function is called
  //   return: how the return value is generated
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
  ret['call'] = wrapReturn(
      match.group(1), '${match.group(2)}(${args.list.join(',')})', '_tmp');
  ret['args'] = args.data;

  return ret;
}

/// Parse a single method.
Map<String, dynamic> parseMethod(String method, bool constructor) {
  // We need the following fields:
  //
  // - name: method name
  //   call: how the method is called (only used for pure methods)
  //   argslist: list of method arguments (only used for constuctors)
  //   return: how the return value is generated
  //   args:
  //   - argi: argument index
  //     name: argument variable name
  //     type: argument C++ type
  //     conv: Dart API function to convert this argument

  var match = methodRegex.firstMatch(method);

  Map<String, dynamic> ret = {
    'name': match.group(2),
    'return': codeForNewDartHandle(primitiveCType(match.group(1)), '_tmp')
  };

  var args = parseArguments(match.group(3), constructor ? 0 : 1);
  ret['call'] = wrapReturn(match.group(1),
      '_ref -> ${match.group(2)}(${args.list.join(',')})', '_tmp');
  ret['argslist'] = args.list.join(',');
  ret['args'] = args.data;

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
      args.data.add({
        'argi': i + argiOffset,
        'name': match.group(2),
        'type': primitiveType,
        'conv': dartToCTypeConv[primitiveType]
      });

      args.list.add(castToType(match.group(1), match.group(2), true, false));
    }
  }

  return args;
}

/// Convert type name to pure C type.
String primitiveCType(String type) {
  if (dartToCType.containsKey(type)) {
    return dartToCType[type];
  } else if (type.endsWith('*')) {
    // This is a pointer: store as int64_t
    return 'int64_t';
  } else {
    // Assume this is an enumeration: store as int64_t
    return 'int64_t';
  }
}

/// Wrap function call [call] so that the return value of type [type] is casted
/// and stored in [dstvar].
String wrapReturn(String type, String call, String dstvar) {
  if (type == 'void') {
    return call;
  } else {
    return '${primitiveCType(type)} $dstvar = ${castToType(type, call, false, true)}';
  }
}

/// Cast the output of [call] to [type] (return value of the call is derived
/// from [type]). If [realloc] is set it will reallocate const char* types.
/// If [reverse] is set it will cast enums and pointers to `int64_t`.
String castToType(String type, String call, bool realloc, bool reverse) {
  if (noCastTypes.contains(type)) {
    return call;
  } else if (type == 'String') {
    // Copy into new string if we need a realloc.
    return realloc ? 'newstr($call)' : call;
  } else if (type.endsWith('*')) {
    // This is a pointer: implicit cast
    return '(${reverse ? 'int64_t' : type})$call';
  } else {
    // Assume this is an enumeration: do static_cast<>
    return 'static_cast<${reverse ? 'int64_t' : type}>($call)';
  }
}

// Generate code for creating a new Dart_Handle from the given C type and source
// variable name.
String codeForNewDartHandle(String type, String srcvar) {
  if (newDartHandle.containsKey(type)) {
    return '${newDartHandle[type]}($srcvar)';
  } else {
    return 'Dart_Null()';
  }
}
