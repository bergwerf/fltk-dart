// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

/// A simple text editor using FLTK and Dart, inspired by the 'Designing a
/// Simple Text Editor' tutorial from FLTK.

import 'dart:async';
import 'dart:isolate';

import 'package:fltk/fltk.dart' as fl;

/// DartPad in Dart!
class DartPad extends fl.DoubleWindow {
  /// Code editor
  fl.TextEditor codeEditor;

  /// Code buffer
  fl.TextBuffer codeBuffer;

  /// Toolbar group
  fl.Group toolbar;

  /// Run button
  fl.Button runButton;

  /// Console output
  fl.TextEditor console;

  /// Console buffer
  fl.TextBuffer consoleBuffer;

  /// Constructor
  DartPad(int _w, int _h, String l, [String defaultPath = null])
      : super(_w, _h, l) {
    // Global theme settings
    fl.scheme('gleam');
    fl.background(38, 38, 38);
    fl.foreground(51, 51, 51);
    fl.option(fl.Option.VISIBLE_FOCUS, false);
    fl.setColor(fl.SELECTION_COLOR, 64, 64, 64);

    final bg1 = fl.grayscale(51);
    final bg2 = fl.grayscale(32);

    color = bg2;
    final width = _w;
    final height = _h;
    final half1 = (_w / 2).round();
    final half2 = width - half1;

    // Create toolbar group.
    final pad = 5; // Toolbar padding
    final bh = 32; // Button height
    toolbar = new fl.Group(0, 0, half1, bh + 2 * pad);
    toolbar.box = fl.FLAT_BOX;
    toolbar.color = bg1;

    // Create run button.
    runButton = new fl.Button(half1 - 80 - pad, pad, 80, bh, '▶  Run');
    runButton.box = fl.FLAT_BOX;
    runButton.color = bg1;
    runButton.labelcolor = fl.grayscale(255);
    runButton.labelsize = 16;

    toolbar.resizable =
        new fl.Widget(0, 0, toolbar.w - pad - runButton.w, toolbar.h);
    toolbar.end();

    // Fancy text editor setup
    final setupEditor = (fl.TextEditor editor) {
      editor.box = fl.FLAT_BOX;
      editor.cursorStyle = fl.TextDisplay.SIMPLE_CURSOR;
      editor.textFont = fl.COURIER;
      editor.textSize = 18;
      editor.linenumberWidth = 60;
      editor.linenumberSize = 18;
      editor.linenumberFormat = '%d ';
      editor.linenumberFont = fl.COURIER_BOLD;
      editor.scrollbarBox = fl.FLAT_BOX;
      editor.scrollbarTrackColor = bg1;
    };

    // Create code editor.
    codeEditor = new fl.TextEditor(0, toolbar.h, half1, height - toolbar.h);
    setupEditor(codeEditor);

    codeEditor.color = bg1;
    codeEditor.linenumberBgColor = bg1;
    codeEditor.linenumberFgColor = fl.grayscale(128);
    codeEditor.cursorColor = fl.grayscale(223);
    codeEditor.textColor = fl.grayscale(223);

    // Setup code buffer.
    codeBuffer = new fl.TextBuffer();
    codeEditor.buffer = codeBuffer;
    codeBuffer.text = "print('Hello World!');\n";

    // Create console.
    final cpad = 20; // Console padding
    console = new fl.TextEditor(half1, 0, half2, height);
    console.deactivate();
    setupEditor(console);

    console.color = bg2;
    console.linenumberBgColor = bg2;
    console.linenumberWidth = cpad;
    console.linenumberFormat = '';
    console.linenumberSize = 10;
    console.textColor = fl.grayscale(128);

    // Setup console buffer.
    consoleBuffer = new fl.TextBuffer();
    console.buffer = consoleBuffer;
    consoleBuffer.text = '\nWelcome to DartPad!\n';

    resizable = new fl.Widget(0, toolbar.h, width, height - toolbar.h);

    // Setup run code event.
    runButton.onCallback.listen((_) {
      var code = codeBuffer.text;

      // Prepend line ending for search porposes.
      code = '\n$code';

      // Split code into imports and code.
      final regex = new RegExp(r'''\n\s*import ["'].*["'];''');
      final matches = regex.allMatches(code);
      final splixIndex = matches.isNotEmpty ? matches.last.end : 0;
      final imports = code.substring(0, splixIndex);
      code = code.substring(splixIndex);

      // Wrap code in a special wrapper that proves a special print function.
      final wrappedCode = '''
/// All imports
$imports

/// Main
main(List<String> args, SendPort __printSendPort) {
  // Define new print function.
  final print = (String line) {
    __printSendPort.send(line);
  };

  // Run actual code.
  $code
}
''';

      // Receive port for isolate errors
      final onError = new ReceivePort();
      onError.listen((e) {
        print('An error has occured:\n$e');
      });

      // Receive port for isolate print messages
      final onPrint = new ReceivePort();
      onPrint.listen((msg) {
        println(msg);
      });

      // Receive port for isolate exit event
      final onExit = new ReceivePort();
      onExit.listen((msg) {
        println('Isolate exited.');
        onError.close();
        onPrint.close();
        onExit.close();
      });

      // Start isolate.
      println('Starting isolate...');
      Isolate.spawnUri(
          new Uri.dataFromString(wrappedCode), [], onPrint.sendPort,
          onError: onError.sendPort,
          onExit: onExit.sendPort,
          errorsAreFatal: true);
    });
  }

  /// Add line to console.
  void println(String line) {
    consoleBuffer.text += '$line\n';
  }
}

Future main(List<String> args) {
  var pad = new DartPad(720, 480, 'DartPad', args.isNotEmpty ? args[0] : null);
  pad.show();
  return fl.runAsync();
}
