// ignore_for_file: prefer_interpolation_to_compose_strings, depend_on_referenced_packages

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../print.dart';
import 'consts.dart';

@lazySingleton
class PusherChannels {
  final PusherChannelsFlutter pusher;
  PusherChannels({required this.pusher});
  String socketId = '';
  Future<void> init({
    required Function() onConnected,
    required Function(PusherEvent) onEvent,
  }) async {
    await pusher.init(
      onAuthorizer: onAuthorizer,
      apiKey: PusherEnv.API_KEY,
      cluster: PusherEnv.API_CLUSTER,
      onError: (message, code, error) {
        kPrint('onError $message $error $code');
      },
      onConnectionStateChange: (currentState, previousState) async {
        kPrint('onConnectionStateChange $currentState');
        if (currentState == 'CONNECTED') {
          socketId = await getSocketId();
          kPrint(socketId);
          await Future.delayed(const Duration(seconds: 2), onConnected);
        }
      },
      onEvent: (event) {
        onEvent(event);
      },
    );
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    final userData = jsonEncode({
      "chat-type": "customer service",
    });
    final secretBody = "$socketId:$channelName:$userData";
    final secretkey = utf8.encode(PusherEnv.SECRET);
    final secretBodyInBytes = utf8.encode(secretBody);
    final hmacSha256 = Hmac(sha256, secretkey);
    final signature = hmacSha256.convert(secretBodyInBytes);
    final auth = "${PusherEnv.API_KEY}:$signature";
    final res = {
      "auth": auth,
      "channel_data": userData,
    };
    kPrint(res);
    return res;
  }

  Future<void> subscribe({
    required String channel,
  }) async {
    await pusher.subscribe(channelName: channel);
    await pusher.connect();
  }

  Future<String> getSocketId() async => pusher.getSocketId();

  Future<void> trigger({
    required String channel,
    required String event,
    required Map<String, dynamic> data,
  }) async {
    await pusher.trigger(
      PusherEvent(
        channelName: channel,
        eventName: event,
        data: jsonEncode(data),
      ),
    );
  }

  Future<void> unsubscribe({required String channel}) async {
    await pusher.unsubscribe(channelName: channel);
  }

  Future<void> disconnect() async {
    await pusher.disconnect();
  }

  Future<void> sendEvent({
    required String event,
    required String channel,
    required Map<String, dynamic> data,
    required String socketId,
  }) async {
    final params = jsonEncode({
      "name": event,
      "channel": channel,
      "data": jsonEncode(data),
      "socket_id": socketId,
    });
    final bodyMd5 = md5.convert(utf8.encode(params));
    final secretBody =
        "POST\n/apps/${PusherEnv.APP_ID}/events\nauth_key=${PusherEnv.API_KEY}&"
        "auth_timestamp=${PusherEnv.TIMESTAMP}&auth_version=${PusherEnv.AUTH_VERSION}&body_md5=$bodyMd5";
    final secretkey = utf8.encode(PusherEnv.SECRET);
    final secretBodyInBytes = utf8.encode(secretBody);
    final hmacSha256 = Hmac(sha256, secretkey);
    final signature = hmacSha256.convert(secretBodyInBytes);
    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final path =
        "https://api-${PusherEnv.API_CLUSTER}.pusher.com/apps/${PusherEnv.APP_ID}"
        "/events?auth_key=${PusherEnv.API_KEY}&auth_timestamp=${PusherEnv.TIMESTAMP}"
        "&auth_version=${PusherEnv.AUTH_VERSION}&body_md5=$bodyMd5&auth_signature=$signature";
    final res = await http.post(
      Uri.parse(path),
      headers: headers,
      body: params,
    );
    kPrint(res.body);
    kPrint(res.statusCode);
  }
}
