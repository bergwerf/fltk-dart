#include <FL/Fl.H>
#include <FL/Fl_Window.H>

int main(int argc, char **argv) {
  Fl_Window *window = new Fl_Window(300, 180, "Hello World!");
  window -> show();
  return Fl::run();
}
