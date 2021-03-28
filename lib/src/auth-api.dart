import 'package:shelf_router/shelf_router.dart';

// import 'util.dart';

import 'package:shelf/shelf.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AuthApi {
  DbCollection store;
  String scret;

  AuthApi(this.store, this.scret);

  Router get router {
    final router = Router();

    router.post('/register', (Request request) async {
      return Response.ok('Responseee');
    });
    return router;
  }
}
