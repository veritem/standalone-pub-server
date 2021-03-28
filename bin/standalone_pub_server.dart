import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:standalone_pub_server/standalone_pub_server.dart'
    as standalone_pub_server;

void main(List<String> arguments) async {
  final app = Router();

  app.get('/assets/<file|.*>', createStaticHandler('public'));

  app.get('/<name|.*>', (Request request) {
    final indexFile = File('public/index.html').readAsStringSync();
    return Response.ok(indexFile, headers: {'content-type': 'text/html'});
  });

  await io.serve(app, 'localhost', 8080);
}
