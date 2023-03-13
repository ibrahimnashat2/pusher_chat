// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class PusherEnv {
  static const PROJECT_ID = '37d86909-c315-4927-95bc-06f60601c38d';
  static const BEARER_TOKEN =
      '543747910FBD5CEBE599EC88604D4ACB55D6D478A582F59C370D5646D242A3AC';
  static const API_KEY = 'f821748907f137a77a2a';
  static const API_CLUSTER = 'eu';
  static const APP_ID = '1549449';
  static const SECRET = 'ca753df793f14c3651ae';
  static const AUTH_VERSION = '1.0';

  static String TIMESTAMP =
      "${DateTime.now().millisecondsSinceEpoch}".substring(0, 10);
}
