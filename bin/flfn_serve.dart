// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:watcher/watcher.dart';
import 'package:vm_service_lib/vm_service_lib.dart' hide Null;

const vmServicePort = 8282;
const vmServiceHost = 'localhost';

VmService createServiceClient(
    WebSocket socket, StreamController<String> controller,
    [Log log]) {
  return new VmService(
      controller.stream, (String message) => socket.add(message),
      log: log, disposeHandler: () => socket.close());
}

Future<Null> main(List<String> args) async {
  // Return if there are no args.
  if (args.isEmpty) {
    print('Please specify the entry Dart file.');
    exit(0);
  }

  // Run entry point.
  final process = await Process
      .start('dart', ['--enable-vm-service=$vmServicePort', args.first]);
  process.stdout.transform(UTF8.decoder).listen(print);
  process.stderr.transform(UTF8.decoder).listen(print);

  // Wait for 500ms.
  // This is a super ugly solution for listening to the process output untill it
  // prints the Observatory URL.
  await new Future.delayed(new Duration(milliseconds: 500));

  var isolateId = '';
  final controller = new StreamController<String>();

  // Connect to WebSocket interface.
  final ws =
      await await WebSocket.connect('ws://$vmServiceHost:$vmServicePort/ws');
  ws.listen((json) {
    controller.add(json);

    final data = JSON.decode(json) as Map;
    if (data.containsKey('result') &&
        (data['result'] as Map).containsKey('type') &&
        data['result']['type'] == 'ReloadReport' &&
        (data['result'] as Map).containsKey('success') &&
        data['result']['success']) {
      // Send `ext.fltk.flfn.rebuild` to Dart VM to trigger GUI reconfiguration.
      ws.add(JSON.encode({
        'jsonrpc': '2.0',
        'method': 'ext.fltk.flfn.rebuild',
        'params': {'isolateId': '$isolateId'}
      }));
    }
  });

  // Create VM service client from WebSocket.
  final serviceClient = createServiceClient(ws, controller);

  // Figure out main isolate ID.
  final vm = await serviceClient.getVM();
  isolateId =
      vm.isolates.first.id; // TODO: scan for the main isolate instead of this.

  // Watch for changes under current directory.
  new DirectoryWatcher(Directory.current.path).events.listen((event) {
    if (event.type == ChangeType.MODIFY && event.path.endsWith('.dart')) {
      // Send `_reloadSources` to Dart VM to triger code reload.
      ws.add(JSON.encode({
        'jsonrpc': '2.0',
        'method': '_reloadSources',
        'params': {'isolateId': '$isolateId'}
      }));
    }
  });
}
