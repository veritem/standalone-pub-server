import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:standalone_pub_server/standalone_pub_server.dart';

void main(List<String> arguments) async {
  final db = await Db.create(
      "mongodb+srv://mdenyse:maniraguha@demo.y7ysb.mongodb.net/testdb?retryWrites=true&w=majority");

  await db.open();
  print('Connected to the database successfully');

  final store = db.collection('users');

  final app = Router();

  app.mount('/auth/', AuthApi(store, "my_scret").router);
  app.mount('/users/', UserApi().router);

  app.get('/assets/<file|.*>', createStaticHandler('public'));

  app.get('/<name|.*>', (Request request) {
    final indexFile = File('public/index.html').readAsStringSync();
    return Response.ok(indexFile, headers: {'content-type': 'text/html'});
  });

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addHandler(app);

  await io.serve(handler, 'localhost', 8080);
}
