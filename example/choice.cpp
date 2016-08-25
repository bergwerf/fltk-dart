// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl.H>
#include <FL/Fl_Choice.H>
#include <FL/Fl_Double_Window.H>
#include <cstdio>

struct SpaceAgency {
  int usdBudget;
  Fl_Color color;
};

void callback(Fl_Widget *widget, void *data) {
  auto choice = (Fl_Choice*)widget;
  auto agency = (SpaceAgency*)data;
  choice -> color(agency -> color);
  printf("%i USD\n", agency -> usdBudget);
}

int main(int argc, char* argv[]) {
  Fl::scheme("gtk+");
  auto window = new Fl_Double_Window(420, 80, "Annual budget");
  auto choice = new Fl_Choice(150, 20, 250, 40, "Space agency:   ");
  choice -> add(
    "NASA", FL_CTRL + 'n', callback, new SpaceAgency{19300, FL_YELLOW});
  choice -> add(
    "Roscosmos", FL_CTRL + 'r', callback, new SpaceAgency{5600, FL_GREEN});
  choice -> add(
    "ESA", FL_CTRL + 'e', callback, new SpaceAgency{5510, FL_CYAN});
  window -> show();
  return Fl::run();
}
