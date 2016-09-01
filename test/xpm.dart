// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:fltk/fltk.dart' as fl;

/// A cat XPM image
const xpmCat = const [
  '50 34 4 1',
  '  c black',
  'o c #ff9900',
  '@ c #ffffff',
  '# c None',
  '##################################################',
  '###      ##############################       ####',
  '### ooooo  ###########################  ooooo ####',
  '### oo  oo  #########################  oo  oo ####',
  '### oo   oo  #######################  oo   oo ####',
  '### oo    oo  #####################  oo    oo ####',
  '### oo     oo  ###################  oo     oo ####',
  '### oo      oo                     oo      oo ####',
  '### oo       oo  ooooooooooooooo  oo       oo ####',
  '### oo        ooooooooooooooooooooo        oo ####',
  '### oo     ooooooooooooooooooooooooooo    ooo ####',
  '#### oo   ooooooo ooooooooooooo ooooooo   oo #####',
  '####  oo oooooooo ooooooooooooo oooooooo oo  #####',
  '##### oo oooooooo ooooooooooooo oooooooo oo ######',
  '#####  o ooooooooooooooooooooooooooooooo o  ######',
  '###### ooooooooooooooooooooooooooooooooooo #######',
  '##### ooooooooo     ooooooooo     ooooooooo ######',
  '##### oooooooo  @@@  ooooooo  @@@  oooooooo ######',
  '##### oooooooo @@@@@ ooooooo @@@@@ oooooooo ######',
  '##### oooooooo @@@@@ ooooooo @@@@@ oooooooo ######',
  '##### oooooooo  @@@  ooooooo  @@@  oooooooo ######',
  '##### ooooooooo     ooooooooo     ooooooooo ######',
  '###### oooooooooooooo       oooooooooooooo #######',
  '###### oooooooo@@@@@@@     @@@@@@@oooooooo #######',
  '###### ooooooo@@@@@@@@@   @@@@@@@@@ooooooo #######',
  '####### ooooo@@@@@@@@@@@ @@@@@@@@@@@ooooo ########',
  '######### oo@@@@@@@@@@@@ @@@@@@@@@@@@oo ##########',
  '########## o@@@@@@ @@@@@ @@@@@ @@@@@@o ###########',
  '########### @@@@@@@     @     @@@@@@@ ############',
  '############  @@@@@@@@@@@@@@@@@@@@@  #############',
  '##############  @@@@@@@@@@@@@@@@@  ###############',
  '################    @@@@@@@@@    #################',
  '####################         #####################',
  '##################################################',
];

int main() {
  final window = new fl.DoubleWindow(2 * 96, 96);
  window.color = fl.grayscale(51);
  final dartIcon = new fl.Box(32, 32, 32, 32);
  dartIcon.image = fl.readXpm(fl.xpmDartIcon);
  final catImage = new fl.Box(96 + 32, 32, 32, 32);
  catImage.image = fl.readXpm(xpmCat);
  window.end();
  window.show();
  return fl.run();
}
