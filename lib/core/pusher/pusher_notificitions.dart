import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:pusher_beams/pusher_beams.dart';

import '../print.dart';
import 'consts.dart';

@lazySingleton
class PusherNotificitions {
  final PusherBeams pusher;
  PusherNotificitions({
    required this.pusher,
  });
  final BeamsAuthProvider provider = BeamsAuthProvider()
    ..authUrl = 'https://some-auth-url.com/secure'
    ..headers = {'Content-Type': 'application/json'}
    ..queryParams = {'page': '1'}
    ..credentials = 'omit';

  Future<void> init() async {
    await pusher.start(PusherEnv.PROJECT_ID);
  }

  Future<void> setUser({required String userId}) async {
    await pusher.setUserId(userId, provider, (error) {
      if (error != null) {
        kPrint(error);
      }
    });
  }

  Future<Map<String, dynamic>?> getInitMessage() async {
    return await pusher.getInitialMessage();
  }

  Future<void> getDevicesInterest() async {
    final res = await pusher.getDeviceInterests();
    kPrint(res);
  }

  Future<void> addDeviceInterest(String interest) async {
    await pusher.addDeviceInterest(interest);
  }

  Future<void> removeInterest(String interest) async {
    await pusher.removeDeviceInterest(interest);
  }

  Future<void> onInterestChanges() async {
    await pusher.onInterestChanges((interests) {
      kPrint(interests);
    });
  }

  Future<void> onFCMForground({
    required Function(Map<String, dynamic>) onEvent,
  }) async {
    await pusher.onMessageReceivedInTheForeground((notification) {
      final data = jsonEncode(notification);
      Map<String, dynamic> json = jsonDecode(data);
      onEvent(json['data']);
    });
  }

  Future<void> sendFCM({
    required String title,
    required String body,
    required String toUser,
    Map<String, dynamic>? data,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${PusherEnv.BEARER_TOKEN}"
    };
    const path =
        "https://${PusherEnv.PROJECT_ID}.pushnotifications.pusher.com/publish_api/v1/instances/${PusherEnv.PROJECT_ID}/publishes";
    final res = await http.post(
      Uri.parse(path),
      headers: headers,
      body: notificationBody(
        body: body,
        title: title,
        toUser: toUser,
        data: data,
      ),
    );
    kPrint(res.body);
  }

  Future<void> dispose() async {
    await pusher.stop();
  }

  String notificationBody({
    required String title,
    required String body,
    required String toUser,
    Map<String, dynamic>? data,
  }) {
    final message = {
      "title": title,
      "body": body,
      "image": "image",
      "status": "status",
    };
    if (data != null) {
      message['data'] = jsonEncode(data);
    }
    return json.encode({
      "interests": [toUser],

      ///[for android systems]
      "fcm": {
        ///[in case have image or any item]
        "data": message
      },

      ///[for ios systems]
      "apns": {
        "aps": {
          ///[in case have image or any item]
          "data": message
        }
      },
    });
  }
}
