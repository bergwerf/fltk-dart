// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:image/image.dart';
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

/// Class to manage a single text display or editor.
class StyledText<T extends fl.TextDisplay> {
  T d;

  /// Text buffer and style buffer
  fl.TextBuffer textBuffer, styleBuffer;

  StyledText() {
    textBuffer = new fl.TextBuffer();
    styleBuffer = new fl.TextBuffer();
  }

  /// Initialize
  void init(List<fl.StyleEntry> styletable) {
    d.highlightData(styleBuffer, styletable);
    d.buffer = textBuffer;
    d.box = fl.FLAT_BOX;
    d.cursorStyle = fl.TextDisplay.SIMPLE_CURSOR;
    d.textFont = fl.COURIER;
    d.textSize = 18;
    d.linenumberFont = fl.COURIER_BOLD;
    d.scrollbarBox = fl.FLAT_BOX;
    d.scrollbarTrackColor = fl.grayscale(51);
  }
}

/// DartPad in Dart!
class DartPad extends fl.DoubleWindow {
  /// Code editor
  final editor = new StyledText<fl.TextEditor>();

  /// Console output
  final console = new StyledText<fl.TextDisplay>();

  /// Toolbar group
  fl.Group toolbar;

  /// Run button
  fl.Button runButton;

  /// Dart keywords
  static const dartKeywords = const [
    // Types
    'num', 'int', 'double', 'String', 'List', 'Map',

    // Keywords
    'abstract', 'continue', 'false', 'new', 'this',
    //
    'as', 'default', 'final', 'null', 'throw',
    //
    'assert', 'deferred', 'finally', 'operator', 'true',
    //
    'async', 'do', 'for', 'part', 'try',
    //
    'async*', 'dynamic', 'get', 'rethrow', 'typedef',
    //
    'await', 'else', 'if', 'return', 'var',
    //
    'break', 'enum', 'implements', 'set', 'void',
    //
    'case', 'export', 'import', 'static', 'while',
    //
    'catch', 'external', 'in', 'super', 'with',
    //
    'class', 'extends', 'is', 'switch', 'yield',
    //
    'const', 'factory', 'library', 'sync*', 'yield*'
  ];

  /// Editor style table
  final editorStyleTable = [
    // A - Normal text
    new fl.StyleEntry(color: fl.grayscale(223), font: fl.COURIER, size: 18),

    // B - Comments
    new fl.StyleEntry(
        color: fl.grayscale(151), font: fl.COURIER_BOLD_ITALIC, size: 18),

    // C - Keywords
    new fl.StyleEntry(
        color: fl.rgbColor(255, 160, 255), font: fl.COURIER_BOLD, size: 18),

    // D - Strings
    new fl.StyleEntry(
        color: fl.rgbColor(80, 223, 80), font: fl.COURIER, size: 18)
  ];

  /// Console style table
  final consoleStyleTable = [
    // A - Normal text
    new fl.StyleEntry(color: fl.grayscale(223), font: fl.COURIER, size: 18),

    // B - Errors
    new fl.StyleEntry(
        color: fl.rgbColor(255, 80, 80), font: fl.COURIER, size: 18)
  ];

  /// Constructor
  DartPad(int _w, int _h, String l, [String defaultPath = null])
      : super(_w, _h, l) {
    // Global theme settings
    fl.scheme = 'gleam';
    fl.background(38, 38, 38);
    fl.foreground(128, 128, 128);
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
    runButton = new fl.Button(half1 - 90 - pad, pad, 90, bh, ' Run');
    runButton.image =
        copyResize(copyRotate(fl.readXpm(fl.xpmDartIcon), -45.0), 24);
    runButton.align = fl.ALIGN_IMAGE_NEXT_TO_TEXT;
    runButton.box = fl.FLAT_BOX;
    runButton.color = bg1;
    runButton.labelcolor = fl.grayscale(255);
    runButton.labelsize = 16;

    toolbar.resizable =
        new fl.Widget(0, 0, toolbar.w() - pad - runButton.w(), toolbar.h());
    toolbar.end();

    // Create code editor.
    editor.d = new fl.TextEditor(0, toolbar.h(), half1, height - toolbar.h());
    editor.init(editorStyleTable);
    editor.d.color = bg1;
    editor.d.linenumberWidth = 60;
    editor.d.linenumberBgColor = bg1;
    editor.d.linenumberFgColor = fl.grayscale(128);
    editor.d.linenumberFormat = '%d ';
    editor.d.linenumberSize = 18;
    editor.d.cursorColor = fl.grayscale(223);
    editor.d.textColor = fl.grayscale(223);

    // Setup editor syntax highlighting.
    editor.textBuffer.onModify.listen((data) {
      if (data.nInserted != 0 || data.nDeleted != 0) {
        updateEditorSyntax();
      }
    });
    editor.textBuffer.text = defaultDartCode;

    // Create console.
    final cpad = 20; // Console padding
    console.d = new fl.TextDisplay(half1, 0, half2, height);
    console.init(consoleStyleTable);
    console.d.color = bg2;
    console.d.linenumberWidth = cpad;
    console.d.linenumberBgColor = bg2;
    console.d.linenumberFormat = '';
    console.d.linenumberSize = 10;
    console.textBuffer.text = '\nWelcome to DartPad!\n';
    console.styleBuffer.text = strSeq('A', console.textBuffer.text.length);

    // Make window resizable.
    resizable = new fl.Widget(0, toolbar.h(), width, height - toolbar.h());

    // Setup run code event.
    runButton.onCallback.listen((_) {
      runCode();
    });
  }

  /// Update editor syntax highlighting.
  void updateEditorSyntax() {
    final text = editor.textBuffer.text;
    var style = '';
    var current = 'A';
    var next = 'A';

    // String parsing
    var strOpen = [0];
    final handleStringDelimiter = (int n) {
      if (strOpen[0] == 0) {
        strOpen[0] = n;
        current = 'D';
        next = 'D';
      } else if (strOpen[0] == n) {
        strOpen[0] = 0;

        if (strOpen.length == 1) {
          next = 'A';
        }
      }
    };

    // Go through each character.
    for (var i = 0; i < text.length; i++) {
      current = next;

      if (text.startsWith('//', i)) {
        current = 'B';
        next = 'B';
      } else if (text.startsWith('\n', i)) {
        current = 'A';
        next = 'A';
      } else if (current != 'B') {
        if (text.startsWith("'", i)) {
          handleStringDelimiter(1);
        } else if (text.startsWith('"', i)) {
          handleStringDelimiter(2);
        } else if (strOpen[0] > 0 && text.startsWith('{', i)) {
          strOpen.insert(0, 0);
        } else if (strOpen.length > 1 && text.startsWith('}', i)) {
          strOpen.removeAt(0);
        } else {
          for (final keyword in dartKeywords) {
            if (text.startsWith('$keyword ', i)) {
              style += strSeq('C', keyword.length);
              i += keyword.length;
              current = 'A';
              continue;
            }
          }
        }
      }

      style += current;
    }

    editor.styleBuffer.text = style;
    editor.d.redraw();
  }

  /// Execute editor code.
  void runCode() {
    var code = editor.textBuffer.text;

    // Prepend line ending for search porposes.
    code = '\n$code';

    // Split code into imports and code.
    final regex = new RegExp(r'''\n\s*import ["'].*["'];''');
    final matches = regex.allMatches(code);
    final splixIndex = matches.isNotEmpty ? matches.last.end : 0;
    final imports = code.substring(0, splixIndex);
    code = code.substring(splixIndex);

    // Wrap code in a special wrapper that proves a special print function.
    final wrappedCode = createWrappedCode(imports, code);

    // Code data URI.
    final uri = new Uri.dataFromString(wrappedCode);

    // Receive port for isolate errors
    final onError = new ReceivePort();
    onError.listen((e) {
      // Replace URI references in stack trace.
      var msg = e[0].toString();
      final regex = r'\(' + escapeAll(uri.toString()) + r':[0-9]*:[0-9]*\)';
      msg = msg.replaceAll(new RegExp(regex), '(DartPad)');

      // Prettify a little more.
      msg = msg.replaceAll("'$uri': ", '');
      msg = msg.replaceFirst(', #0', ',\n#0');
      msg = msg.trimRight();

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
      msg = msg.replaceAll("'$uri': ", '');

      println(msg, error: true);

      // Close send ports.
      onError.close();
      onPrint.close();
      onExit.close();
    });
  }

  /// Add line to console.
  void println(String line, {bool error: false}) {
    line = '$line\n';
    console.textBuffer.text += line;

    // Add to style buffer.
    console.styleBuffer.text += strSeq(error ? 'B' : 'A', line.length);

    // Scroll all the way down.
    console.d.scroll(console.textBuffer.text.split('\n').length, 0);
  }
}

Future main(List<String> args) {
  var pad = new DartPad(720, 480, 'DartPad', args.isNotEmpty ? args[0] : null);
  pad.show();
  return fl.runAsync(new Duration(milliseconds: 10));
}

String createWrappedCode(String imports, String code) {
  return '''
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
}

const defaultDartCode = r'''
/// Recursive
int fib(int n) {
  if (n <= 1) {
    return n;
  }

  return fib(n - 1) + fib(n - 2);
}

/// Loop
int fastFib(int n) {
  int a = 1, b = 0, temp;

  while (n > 0){
    temp = a;
    a = a + b;
    b = temp;
    n--;
  }

  return b;
}

print('5th Fibonacci number: ${fib(5)}');
print('10th Fibonacci number: ${fib(10)}');
print('20th Fibonacci number: ${fastFib(20)}');
print('40th Fibonacci number: ${fastFib(40)}');
''';
