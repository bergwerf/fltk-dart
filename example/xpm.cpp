// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl.H>
#include <FL/Fl_Box.H>
#include <FL/Fl_Pixmap.H>
#include <FL/Fl_Double_Window.H>

static const char *cat_xpm[] = {
  "50 34 4 1",
  "  c black",
  "o c #ff9900",
  "@ c #ffffff",
  "# c None",
  "##################################################",
  "###      ##############################       ####",
  "### ooooo  ###########################  ooooo ####",
  "### oo  oo  #########################  oo  oo ####",
  "### oo   oo  #######################  oo   oo ####",
  "### oo    oo  #####################  oo    oo ####",
  "### oo     oo  ###################  oo     oo ####",
  "### oo      oo                     oo      oo ####",
  "### oo       oo  ooooooooooooooo  oo       oo ####",
  "### oo        ooooooooooooooooooooo        oo ####",
  "### oo     ooooooooooooooooooooooooooo    ooo ####",
  "#### oo   ooooooo ooooooooooooo ooooooo   oo #####",
  "####  oo oooooooo ooooooooooooo oooooooo oo  #####",
  "##### oo oooooooo ooooooooooooo oooooooo oo ######",
  "#####  o ooooooooooooooooooooooooooooooo o  ######",
  "###### ooooooooooooooooooooooooooooooooooo #######",
  "##### ooooooooo     ooooooooo     ooooooooo ######",
  "##### oooooooo  @@@  ooooooo  @@@  oooooooo ######",
  "##### oooooooo @@@@@ ooooooo @@@@@ oooooooo ######",
  "##### oooooooo @@@@@ ooooooo @@@@@ oooooooo ######",
  "##### oooooooo  @@@  ooooooo  @@@  oooooooo ######",
  "##### ooooooooo     ooooooooo     ooooooooo ######",
  "###### oooooooooooooo       oooooooooooooo #######",
  "###### oooooooo@@@@@@@     @@@@@@@oooooooo #######",
  "###### ooooooo@@@@@@@@@   @@@@@@@@@ooooooo #######",
  "####### ooooo@@@@@@@@@@@ @@@@@@@@@@@ooooo ########",
  "######### oo@@@@@@@@@@@@ @@@@@@@@@@@@oo ##########",
  "########## o@@@@@@ @@@@@ @@@@@ @@@@@@o ###########",
  "########### @@@@@@@     @     @@@@@@@ ############",
  "############  @@@@@@@@@@@@@@@@@@@@@  #############",
  "##############  @@@@@@@@@@@@@@@@@  ###############",
  "################    @@@@@@@@@    #################",
  "####################         #####################",
  "##################################################",
};

int main() {
  auto window = new Fl_Double_Window(50, 34);
  auto box = new Fl_Box(0, 0, 50, 34);
  auto pixmap = new Fl_Pixmap(cat_xpm);
  box -> image(pixmap);
  window -> end();
  window -> show();
  return Fl::run();
}
