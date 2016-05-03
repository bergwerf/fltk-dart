#ifndef FLTK_DART_WIDGET_H
#define FLTK_DART_WIDGET_H

#include <FL/Fl.H>
#include <FL/Fl_Widget.H>

#include "dart_api.h"

// Dart bindings for Fl_Widget
class Widget {
public:
  static void box(Dart_NativeArguments arguments);
  static void label(Dart_NativeArguments arguments);
  static void show(Dart_NativeArguments arguments);
};

#endif
