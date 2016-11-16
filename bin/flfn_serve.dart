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

Future<Null> main(List<String> args) async {
  // Return if there are no args.
  if (args.isEmpty) {
    print('Please specify the entry Dart file.');
    return;
  }

  // Run entry point.
  final process = await Process.start(
      'dart', ['--enable-vm-service=$vmServicePort', args.first],
      environment: {'FLFN_MODE': 'debug'});
  process.stderr.transform(UTF8.decoder).listen(print);

  // Wait until observatory is launched.
  StreamSubscription sub;
  sub = process.stdout.transform(UTF8.decoder).listen((str) async {
    if (str.startsWith('Observatory listening on http://')) {
      sub.onData(print);
      setupHotReload();
    }
  });
}

Future<Null> setupHotReload() async {
  var isolateId = '';
  final controller = new StreamController<String>();

  // Connect to WebSocket interface.
  final ws = await WebSocket.connect('ws://$vmServiceHost:$vmServicePort/ws');
  ws.listen((json) {
    print(json);

    // Add message to the stream to the VM service lib client.
    controller.add(json);

    // Decode and check if this is a positive source reload.
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
  final serviceClient = new VmService(
      controller.stream, (String message) => ws.add(message),
      log: null, disposeHandler: () => ws.close());

  // Figure out main isolate ID.
  final vm = await serviceClient.getVM();

  // This is probably not the best way. Also, maybe we want to support hot
  // reloading secondary isolates?
  isolateId =
      vm.isolates.reduce((a, b) => a.name.endsWith('\$main') ? a : b).id;

  int id = 100;

  // Watch for changes under current directory.
  new DirectoryWatcher(Directory.current.path).events.listen((event) {
    if (event.type == ChangeType.MODIFY && event.path.endsWith('.dart')) {
      // Send `_reloadSources` to Dart VM to triger code reload.
      ws.add(JSON.encode({
        'id': ++id,
        'jsonrpc': '2.0',
        'method': '_reloadSources',
        'params': {'isolateId': '$isolateId'}
      }));
    }
  });
}
