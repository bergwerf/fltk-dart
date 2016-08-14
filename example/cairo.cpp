// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

// Force enable Cairo
#define USE_X11 1
#define FLTK_HAVE_CAIRO 1

#include <FL/Fl.H>
#include <FL/Fl_Box.H>
#include <FL/Fl_Cairo_Window.H>

static void centered_text(cairo_t *cr, double x0, double y0, double w0, double h0, const char *my_text) {
  cairo_select_font_face(cr, "Sans", CAIRO_FONT_SLANT_OBLIQUE, CAIRO_FONT_WEIGHT_BOLD);
  cairo_set_source_rgba(cr, 0.9, 0.9, 0.4, 0.6);
  cairo_text_extents_t extents;
  cairo_text_extents(cr, my_text, &extents);
  double x = (extents.width / 2 + extents.x_bearing);
  double y = (extents.height / 2 + extents.y_bearing);
  cairo_move_to(cr, x0+w0/2-x, y0+h0/2 - y);
  cairo_text_path(cr,my_text);
  cairo_fill_preserve(cr);
  cairo_set_source_rgba(cr, 0, 0, 0,1);
  cairo_set_line_width(cr, 0.004);
  cairo_stroke(cr);
}

static void round_button(cairo_t* cr, double x0, double y0,
                         double rect_width, double rect_height, double radius,
                         double r, double g, double b, const char *message) {
  double x1, y1;
  x1 = x0 + rect_width;
  y1 = y0 + rect_height;

  if (!rect_width || !rect_height) {
    return;
  }

  // Draw path.
  if (rect_width / 2 < radius) {
    if (rect_height / 2 < radius) {
      cairo_move_to(cr, x0, (y0 + y1)/2);
      cairo_curve_to(cr, x0 ,y0, x0, y0, (x0 + x1) / 2, y0);
      cairo_curve_to(cr, x1, y0, x1, y0, x1, (y0 + y1) / 2);
      cairo_curve_to(cr, x1, y1, x1, y1, (x1 + x0) / 2, y1);
      cairo_curve_to(cr, x0, y1, x0, y1, x0, (y0 + y1) / 2);
    } else {
      cairo_move_to(cr, x0, y0 + radius);
      cairo_curve_to(cr, x0 ,y0, x0, y0, (x0 + x1) / 2, y0);
      cairo_curve_to(cr, x1, y0, x1, y0, x1, y0 + radius);
      cairo_line_to(cr, x1 , y1 - radius);
      cairo_curve_to(cr, x1, y1, x1, y1, (x1 + x0) / 2, y1);
      cairo_curve_to(cr, x0, y1, x0, y1, x0, y1- radius);
    }
  } else {
    if (rect_height / 2 < radius) {
      cairo_move_to(cr, x0, (y0 + y1) / 2);
      cairo_curve_to(cr, x0 , y0, x0 , y0, x0 + radius, y0);
      cairo_line_to(cr, x1 - radius, y0);
      cairo_curve_to(cr, x1, y0, x1, y0, x1, (y0 + y1) / 2);
      cairo_curve_to(cr, x1, y1, x1, y1, x1 - radius, y1);
      cairo_line_to(cr, x0 + radius, y1);
      cairo_curve_to(cr, x0, y1, x0, y1, x0, (y0 + y1) / 2);
    } else {
      cairo_move_to(cr, x0, y0 + radius);
      cairo_curve_to(cr, x0 , y0, x0 , y0, x0 + radius, y0);
      cairo_line_to(cr, x1 - radius, y0);
      cairo_curve_to(cr, x1, y0, x1, y0, x1, y0 + radius);
      cairo_line_to(cr, x1 , y1 - radius);
      cairo_curve_to(cr, x1, y1, x1, y1, x1 - radius, y1);
      cairo_line_to(cr, x0 + radius, y1);
      cairo_curve_to(cr, x0, y1, x0, y1, x0, y1- radius);
    }
  }
  cairo_close_path(cr);

  // Draw gradient.
  cairo_pattern_t *pat= cairo_pattern_create_radial(0.25, 0.24, 0.11, 0.24, 0.14, 0.35);
  cairo_pattern_set_extend(pat, CAIRO_EXTEND_REFLECT);
  cairo_pattern_add_color_stop_rgba(pat, 1.0, r, g, b, 1);
  cairo_pattern_add_color_stop_rgba(pat, 0.0, 1, 1, 1, 1);
  cairo_set_source(cr, pat);
  cairo_fill_preserve(cr);
  cairo_pattern_destroy(pat);

  // Stroke path.
  cairo_set_source_rgba(cr, 0, 0, 0.5, 0.3);
  cairo_set_line_width(cr, 0.03);
  cairo_stroke(cr);

  // Draw inner text.
  cairo_set_font_size(cr, 0.07);
  centered_text(cr,x0,y0,rect_width, rect_height, message);
}

// The cairo rendering cb called during Fl_Cairo_Window::draw()
static void my_cairo_draw_cb(Fl_Cairo_Window *window, cairo_t *cr) {
  int w = window -> w(), h = window -> h();

  cairo_scale(cr, w, h);
  round_button(cr, 0.1, 0.1, 0.8, 0.2, 0.4, 0, 0, 1, "FLTK loves Cairo!");
  round_button(cr, 0.1, 0.4, 0.8, 0.2, 0.4, 1, 0, 0, "Dart loves FLTK!");
  round_button(cr, 0.1, 0.7, 0.8, 0.2, 0.4, 0, 1, 0, "Dart loves Cairo!");

  return;
}

int main(int argc, char** argv) {
  Fl_Cairo_Window window(300, 300);

  window.resizable(&window);
  window.color(FL_WHITE);
  window.set_draw_cb(my_cairo_draw_cb);
  window.show(argc,argv);

  return Fl::run();
}
