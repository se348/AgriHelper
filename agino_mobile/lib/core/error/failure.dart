import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends Failure {
  final String message;

  SignUpFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
