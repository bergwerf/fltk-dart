// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

/// A simple text editor using FLTK and Dart, inspired by the 'Designing a
/// Simple Text Editor' tutorial from FLTK.

import 'dart:async';
import 'dart:isolate';

import 'package:fltk/fltk.dart' as fl;

/// Utility for creating style buffers.
String strSeq(String char, int n) =>
    new String.fromCharCodes(new List<int>.filled(n, char.codeUnitAt(0)));

/// Escape every single character.
String escapeAll(String src) {
  var dst = '';
  for (var i = 0; i < src.length; i++) {
    dst += r'\x' + src.codeUnitAt(i).toRadixString(16);
  }
  return dst;
}

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
  fl.TextDisplay console;

  /// Console buffer and stylebuffer
  fl.TextBuffer consoleBuffer, consoleStyleBuffer;

  /// Console styletable
  final consoleStyleTable = [
    new fl.StyleEntry(color: fl.grayscale(223), font: fl.COURIER, size: 18),
    new fl.StyleEntry(
        color: fl.rgbColor(255, 80, 80), font: fl.COURIER, size: 18)
  ];

  /// Constructor
  DartPad(int _w, int _h, String l, [String defaultPath = null])
      : super(_w, _h, l) {
    // Global theme settings
    fl.scheme('gleam');
    fl.background(38, 38, 38);
    fl.foreground(255, 255, 255);
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

    // Fancy text display setup
    final textDisplaySetup = (fl.TextDisplay editor) {
      editor.box = fl.FLAT_BOX;
      editor.cursorStyle = fl.TextDisplay.SIMPLE_CURSOR;
      editor.textFont = fl.COURIER;
      editor.textSize = 18;
      editor.linenumberFont = fl.COURIER_BOLD;
      editor.scrollbarBox = fl.FLAT_BOX;
      editor.scrollbarTrackColor = bg1;
    };

    // Create code editor.
    codeEditor = new fl.TextEditor(0, toolbar.h, half1, height - toolbar.h);
    textDisplaySetup(codeEditor);
    codeEditor.color = bg1;
    codeEditor.linenumberWidth = 60;
    codeEditor.linenumberBgColor = bg1;
    codeEditor.linenumberFgColor = fl.grayscale(128);
    codeEditor.linenumberFormat = '%d ';
    codeEditor.linenumberSize = 18;
    codeEditor.cursorColor = fl.grayscale(223);
    codeEditor.textColor = fl.grayscale(223);

    // Setup code buffer.
    codeBuffer = new fl.TextBuffer();
    codeEditor.buffer = codeBuffer;
    codeBuffer.text = "print('Hello World!');\n";

    // Create console.
    final cpad = 20; // Console padding
    console = new fl.TextDisplay(half1, 0, half2, height);
    textDisplaySetup(console);
    console.color = bg2;
    console.linenumberWidth = cpad;
    console.linenumberBgColor = bg2;
    console.linenumberFormat = '';
    console.linenumberSize = 10;

    // Setup console buffer.
    consoleBuffer = new fl.TextBuffer();
    console.buffer = consoleBuffer;
    consoleBuffer.text = '\nWelcome to DartPad!\n';

    // Setup console highlighting.
    consoleStyleBuffer = new fl.TextBuffer();
    consoleStyleBuffer.text = strSeq('A', consoleBuffer.text.length);
    console.highlightData(consoleStyleBuffer, consoleStyleTable);

    // Make window resizable.
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

      // Code data URI.
      final uri = new Uri.dataFromString(wrappedCode);

      // Receive port for isolate errors
      final onError = new ReceivePort();
      onError.listen((e) {
        // Replace URI references in stack trace.
        var msg = e.toString();
        final regex = r'\(' + escapeAll(uri.toString()) + r':[0-9]*:[0-9]*\)';
        msg = msg.replaceAll(new RegExp(regex), '(DartPad)');

        // Prettify a little more.
        msg = msg.replaceFirst("'$uri': ", '');
        msg = msg.replaceFirst(', #0', ',\n#0');
        msg = msg.substring(1, msg.length - 2);

        println('An error has occured:\n$msg', error: true);
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
      println('\nSpawning isolate...');
      runZoned(() {
        Isolate.spawnUri(uri, [], onPrint.sendPort,
            onError: onError.sendPort,
            onExit: onExit.sendPort,
            errorsAreFatal: true);
      }, onError: (e) {
        // Remove URI reference from error message.
        var msg = e.toString();
        msg = msg.replaceFirst(" '$uri': ", '\n');

        println(msg, error: true);

        // Close send ports.
        onError.close();
        onPrint.close();
        onExit.close();
      });
    });
  }

  /// Add line to console.
  void println(String line, {bool error: false}) {
    line = '$line\n';
    consoleBuffer.text += line;

    // Add to style buffer.
    consoleStyleBuffer.text += strSeq(error ? 'B' : 'A', line.length);

    // Scroll all the way down.
    console.scroll(consoleBuffer.text.split('\n').length, 0);
  }
}

Future main(List<String> args) {
  var pad = new DartPad(720, 480, 'DartPad', args.isNotEmpty ? args[0] : null);
  pad.show();
  return fl.runAsync();
}
