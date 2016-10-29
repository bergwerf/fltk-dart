// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.flfn;

/// Enviroment variable to enable debug mode.
const envFlFnMode = 'FLFN_MODE';

/// Function that returns an App description.
typedef App AppBuilder();

/// Run the app defined by [builder].
Future<int> runApp(AppBuilder builder, {bool runAsync: false}) async {
  // Check if we are in debug mode.
  final debugMode = Platform.environment.containsKey(envFlFnMode) &&
      Platform.environment[envFlFnMode] == 'debug';

  // Build app configuration.
  final app = builder();

  // Register extension if we are in debug mode.
  if (debugMode) {
    registerExtension('ext.fltk.flfn.rebuild',
        (String method, Map<String, String> parameters) async {
      print('Received ext.fltk.flfn.rebuild trigger');

      // Rebuild app configuration.
      final tmpapp = builder();

      // Merge with current app.
      app.merge(tmpapp);

      return new ServiceExtensionResponse.result(JSON.encode({'merge': true}));
    });
  }

  // Build app.
  app.build();

  // Run app.
  //
  // It is neccesary to use the fl.runAsync approach since the extension
  // uses async processing which is blocked by the low-level fl.run.
  // fl.run can be used if the app is running 'in production'.
  if (debugMode || runAsync) {
    return fl.runAsync(new Duration(milliseconds: 10));
  } else {
    return new Future<int>.value(fl.run());
  }
}
