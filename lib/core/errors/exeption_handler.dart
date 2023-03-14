import 'package:injectable/injectable.dart';

import '../network_info.dart';
import 'exceptions.dart';

abstract class ExceptionHandler {
  Future<T> call<T>({required Function method});
}

@LazySingleton(as: ExceptionHandler)
class ExceptionHandlerImpl implements ExceptionHandler {
  final NetworkInfo network;

  ExceptionHandlerImpl({required this.network});
  @override
  Future<T> call<T>({required Function method}) async {
    if (await network.isConnected) {
      try {
        return await method();
      } catch (e) {
        throw ServerException();
      }
    }
    throw OfflineException();
  }
}
