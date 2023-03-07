import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CachedFailure extends Failure {}

class SensorFailure extends Failure {}

class OfflineFailure extends Failure {}

class GoogleDirectionsFailure extends Failure {}
