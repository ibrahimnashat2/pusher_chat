import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'exceptions.dart';
import 'failures.dart';

abstract class FailureHandler {
  Future<Either<Failure, T>> call<T>({
    required Function method,
  });
}

@LazySingleton(as: FailureHandler)
class FailureHandlerImpl implements FailureHandler {
  @override
  Future<Either<Failure, T>> call<T>({
    required Function method,
  }) async {
    try {
      final res = await method();
      return Right(res);
    } on OfflineException {
      return Left(OfflineFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on CachedException {
      return Left(CachedFailure());
    }
  }
}
