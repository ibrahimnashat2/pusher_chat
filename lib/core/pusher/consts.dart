// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class PusherEnv {
  static const PROJECT_ID = '5a8be8ba-c3e1-4e5d-bf27-caefac74ddea';
  static const BEARER_TOKEN =
      '60D787480B00D14DEEE00463F7DFB97F2EBDD85BED8EB7D98B5EC86A3EF794EC';
  static const API_KEY = 'f821748907f137a77a2a';
  static const API_CLUSTER = 'eu';
  static const APP_ID = '1549449';
  static const SECRET = 'ca753df793f14c3651ae';
  static const AUTH_VERSION = '1.0';

  static String TIMESTAMP =
      "${DateTime.now().millisecondsSinceEpoch}".substring(0, 10);
}
