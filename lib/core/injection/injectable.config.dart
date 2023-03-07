// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:math' as _i12;

import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
import 'package:pusher_chat/chatting-pusher/data/data_sources/chat_local_data_source.dart'
    as _i15;
import 'package:pusher_chat/chatting-pusher/data/data_sources/chat_remote_data_source.dart'
    as _i16;
import 'package:pusher_chat/chatting-pusher/data/repository/chat_repostoiry_impl.dart'
    as _i18;
import 'package:pusher_chat/chatting-pusher/domain/repository/chat_repositroy.dart'
    as _i17;
import 'package:pusher_chat/chatting-pusher/domain/usecases/delete_message.dart'
    as _i19;
import 'package:pusher_chat/chatting-pusher/domain/usecases/disconnect.dart'
    as _i20;
import 'package:pusher_chat/chatting-pusher/domain/usecases/get_all_messages.dart'
    as _i21;
import 'package:pusher_chat/chatting-pusher/domain/usecases/get_all_rooms.dart'
    as _i22;
import 'package:pusher_chat/chatting-pusher/domain/usecases/on_listen_pusher.dart'
    as _i23;
import 'package:pusher_chat/chatting-pusher/domain/usecases/online.dart'
    as _i24;
import 'package:pusher_chat/chatting-pusher/domain/usecases/save_message.dart'
    as _i25;
import 'package:pusher_chat/chatting-pusher/domain/usecases/save_room.dart'
    as _i26;
import 'package:pusher_chat/chatting-pusher/domain/usecases/send_message.dart'
    as _i27;
import 'package:pusher_chat/chatting-pusher/domain/usecases/typing.dart'
    as _i28;
import 'package:pusher_chat/core/errors/exeption_handler.dart' as _i13;
import 'package:pusher_chat/core/errors/failure_handler.dart' as _i3;
import 'package:pusher_chat/core/injection/injectable.dart' as _i29;
import 'package:pusher_chat/core/isar/isar.dart' as _i6;
import 'package:pusher_chat/core/network_info.dart' as _i8;
import 'package:pusher_chat/core/pusher/pusher_channels.dart' as _i14;
import 'package:pusher_chat/core/pusher/pusher_notificitions.dart' as _i11;
import 'package:pusher_chat/core/widget/context.dart' as _i7;
import 'package:pusher_beams/pusher_beams.dart' as _i9;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i3.FailureHandler>(() => _i3.FailureHandlerImpl());
    gh.factory<_i4.GlobalKey<_i4.NavigatorState>>(() => injectionModule.nav);
    gh.lazySingleton<_i5.InternetConnectionChecker>(
        () => injectionModule.connectionChecker);
    gh.lazySingleton<_i6.Isaar>(() => _i6.IsaarImpl());
    gh.factory<_i7.MainContext>(
        () => _i7.Root(nav: gh<_i4.GlobalKey<_i4.NavigatorState>>()));
    gh.factory<_i8.NetworkInfo>(
        () => _i8.NetworkInfoImpl(gh<_i5.InternetConnectionChecker>()));
    gh.lazySingleton<_i9.PusherBeams>(() => injectionModule.puserBeams);
    gh.lazySingleton<_i10.PusherChannelsFlutter>(
        () => injectionModule.pusherChannelsFlutter);
    gh.lazySingleton<_i11.PusherNotificitions>(
        () => _i11.PusherNotificitions(pusher: gh<_i9.PusherBeams>()));
    gh.lazySingleton<_i12.Random>(() => injectionModule.random);
    gh.factory<_i4.ScrollController>(() => injectionModule.scrollController);
    gh.factory<_i4.TextEditingController>(
        () => injectionModule.textEditingController);
    gh.lazySingleton<_i13.ExceptionHandler>(
        () => _i13.ExeptionHandlerImpl(network: gh<_i8.NetworkInfo>()));
    gh.lazySingleton<_i14.PusherChannels>(
        () => _i14.PusherChannels(pusher: gh<_i10.PusherChannelsFlutter>()));
    gh.lazySingleton<_i15.ChatLocalDataSource>(
        () => _i15.ChatLocalDataSourceImpl(
              handler: gh<_i13.ExceptionHandler>(),
              isaar: gh<_i6.Isaar>(),
            ));
    gh.lazySingleton<_i16.ChatRemoteDataSource>(
        () => _i16.ChatRemoteDataSourceImpl(
              pusherChannels: gh<_i14.PusherChannels>(),
              handler: gh<_i13.ExceptionHandler>(),
            ));
    gh.lazySingleton<_i17.ChatRepository>(() => _i18.ChatRepositoryImpl(
          handler: gh<_i3.FailureHandler>(),
          localDataSource: gh<_i15.ChatLocalDataSource>(),
          remoteDataSource: gh<_i16.ChatRemoteDataSource>(),
        ));
    gh.lazySingleton<_i19.DeleteMessage>(
        () => _i19.DeleteMessage(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i20.Disconnect>(
        () => _i20.Disconnect(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i21.GetAllMessages>(
        () => _i21.GetAllMessages(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i22.GetAllRooms>(
        () => _i22.GetAllRooms(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i23.OnListenPusher>(
        () => _i23.OnListenPusher(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i24.Online>(
        () => _i24.Online(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i25.SaveMessage>(
        () => _i25.SaveMessage(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i26.SaveRoom>(
        () => _i26.SaveRoom(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i27.SendMessage>(
        () => _i27.SendMessage(chatRepository: gh<_i17.ChatRepository>()));
    gh.lazySingleton<_i28.Typing>(
        () => _i28.Typing(chatRepository: gh<_i17.ChatRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i29.InjectionModule {}
