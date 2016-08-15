Dart bindings for FLTK!
=======================
How awesome is that!

Integrations
------------
- `image`
- `dartgl` (unstable)
- `cairodart` (not yet implemented)

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
