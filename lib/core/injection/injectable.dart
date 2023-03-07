import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init(environment: 'package-dev');
}

@module
abstract class InjectionModule {
  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  @lazySingleton
  PusherChannelsFlutter get pusherChannelsFlutter =>
      PusherChannelsFlutter.getInstance();

  @lazySingleton
  PusherBeams get puserBeams => PusherBeams.instance;
}
