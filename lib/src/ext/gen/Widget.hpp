#ifndef FLDART_WIDGET_H
#define FLDART_WIDGET_H

#include <string>
#include <FL/Fl.H>
#include <FL/Fl_Widget.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
  // Dart bindings for Fl_Widget
  class Widget {
  public:
    static void box(Dart_NativeArguments arguments);
    static void label(Dart_NativeArguments arguments);
    static void labelfont(Dart_NativeArguments arguments);
    static void labelsize(Dart_NativeArguments arguments);
    static void labeltype(Dart_NativeArguments arguments);
    static void show(Dart_NativeArguments arguments);

    // Method mapping
    static FunctionMapping methods[];
  };
}

#endif
