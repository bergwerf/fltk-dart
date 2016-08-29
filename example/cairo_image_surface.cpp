// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <cstdio>
#include <cairo.h>

typedef signed long long int64_t;

int main() {
  cairo_surface_t *surface;
  cairo_t *cr;

  surface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, 520, 60);
  cr = cairo_create(surface);

  cairo_set_source_rgb(cr, 0, 0, 0);
  cairo_select_font_face(cr, "Sans", CAIRO_FONT_SLANT_NORMAL,
                         CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size(cr, 40.0);

  cairo_move_to(cr, 10.0, 50.0);
  cairo_show_text(cr, "FLTK + Dart = Awesome");

  cairo_surface_flush(surface);
  unsigned char *data = cairo_image_surface_get_data(surface);
  printf("sizeof(data) = %i\n", (int)sizeof(data));

  for (int i = 0; i < 520 * 60 * 4; i++) {
    printf("%i", (int64_t)data[i]);
  }
  printf("\n");

  cairo_destroy(cr);
  cairo_surface_destroy(surface);

  return 0;
}
