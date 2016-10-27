// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:fltk/fltk.dart' as fl;

class SpaceAgency {
  final int usdBudget;
  final int color;
  SpaceAgency(this.usdBudget, this.color);
}

void callback(fl.Widget choice, SpaceAgency agency) {
  choice.color = agency.color;
  print('${agency.usdBudget} USD');
}

int main() {
  fl.scheme = 'gtk+';
  final window = new fl.DoubleWindow(420, 80, 'Annual budget');
  final choice = new fl.Choice(150, 20, 250, 40, 'Space agency:   ');
  choice.add('NASA',
      shortcut: fl.CTRL + 'n',
      callback: callback,
      userData: new SpaceAgency(19300, fl.YELLOW));
  choice.add('Roscosmos',
      shortcut: fl.CTRL + 'r',
      callback: callback,
      userData: new SpaceAgency(5600, fl.GREEN));
  choice.add('ESA',
      shortcut: fl.CTRL + 'e',
      callback: callback,
      userData: new SpaceAgency(5510, fl.CYAN));
  window.show();
  return fl.run();
}
