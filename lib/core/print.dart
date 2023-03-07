import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

void kPrint(dynamic data) {
  if (data is String) {
    _pr(data);
  } else if (data is Map) {
    _pr(jsonEncode(data));
  } else if (data is List) {
    try {
      _pr(data.map((dynamic e) => e.toJson()).toList().toString());
    } catch (e) {
      _pr(data.toString());
    }
  } else {
    _pr(data.toString());
  }
}

void _pr(String data) {
  if (kDebugMode) {
    if (data.length > 500) {
      log(data);
    } else {
      print(data);
    }
    log(StackTrace.current.toString().split('\n')[2]);
  }
}
