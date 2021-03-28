import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

const _hostname = 'localhost';
const _port = 8080;

void main(List<String> args) async {
  final handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addMiddleware((innerHandler) => (request) async {
            final updatedRequest = request
                .change(headers: {'custom header': 'custom header here'});
            return shelf.Response.ok('intercepted');
          })
      .addHandler((request) => shelf.Response.ok("Hello world"));

  final server = await io.serve(handler, _hostname, _port);

  print('serving at http://${server.address.host}:${server.port}');
}
