// ignore_for_file: constant_identifier_names, non_constant_identifier_names

abstract class PusherEnv {
  final PROJECT_ID = '37d86909-c315-4927-95bc-06f60601c38d';
  final BEARER_TOKEN =
      '543747910FBD5CEBE599EC88604D4ACB55D6D478A582F59C370D5646D242A3AC';
  final API_KEY = 'f821748907f137a77a2a';
  final API_CLUSTER = 'eu';
  final APP_ID = '1549449';
  final SECRET = 'ca753df793f14c3651ae';
  final AUTH_VERSION = '1.0';

  String TIMESTAMP =
      "${DateTime.now().millisecondsSinceEpoch}".substring(0, 10);
}
