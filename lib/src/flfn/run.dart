// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.flfn;

/// Function that returns an App description.
typedef App AppBuilder();

/// Run the app defined by [builder].
Future runApp(AppBuilder builder) {
  // Build app configuration.
  final app = builder();

  // Register extension.
  registerExtension('ext.fltk.flfn.rebuild',
      (String method, Map<String, String> parameters) async {
    print('Received ext.fltk.flfn.rebuild trigger');

    // Rebuild app configuration.
    final tmpapp = builder();

    // Merge with current app.
    app.merge(tmpapp);

    return new ServiceExtensionResponse.result('');
  });

  // Build app.
  app.build();

  // Run app.
  return fl.runAsync(new Duration(milliseconds: 10));
}
