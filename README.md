Dart bindings for FLTK!
=======================
Yes! FLTK in Dart, just like this:
```dart
import 'package:fltk/fltk.dart' as fl;

int main() {
  fl.scheme('gleam');
  var window = new fl.Window(350, 180, 'FLTK');
  var box = new fl.Box(20, 40, 310, 100, 'Hello, World!');
  window.end();
  window.show();
  return fl.run();
}
```

Integrations
------------
- `image`
- `dartgl`
- `cairodart` (not yet implemented)

State of the art
----------------
This library is mostly experimental and a way to spend some time. Currently only
a subset of features are supported (the exiting ones like loading images,
displaying OpenGL graphics, and asynchronous event streams). The majority of
widgets is not yet ported to Dart. However a sophisticated code generation
program is already in place and adding simple widgets is pretty easy. If this
library is useful for you and you need more widgets, feel free to open an issue!

Architecture
------------
Most bindings are automatically generated from YAML descriptions of the FLTK
functions and classes. Class bindings do not create the target class directly,
instead they create a wrapper class that takes care of draw and callback
events.

Considerations
--------------
Maybe we should use static linking for the FLTK libraries so this extension can
be used without locally compiling FLTK.
