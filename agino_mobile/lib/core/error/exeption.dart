import 'package:equatable/equatable.dart';

class CacheException extends Equatable implements Exception {
  final String message;
  const CacheException({this.message = 'Cache Exception'});

  @override
  List<Object?> get props => [message];
}

class ServerException extends Equatable implements Exception {
  final String message;
  const ServerException({this.message = 'Server Exception'});

  @override
  List<Object?> get props => [message];
}

class NetworkException extends Equatable implements Exception {
  final String message;
  const NetworkException({this.message = 'Network Exception'});

  @override
  List<Object?> get props => [message];
}

class SignUpException extends Equatable implements Exception {
  final String message;
  const SignUpException({this.message = 'Signup Exception'});

  @override
  List<Object?> get props => [message];
}
