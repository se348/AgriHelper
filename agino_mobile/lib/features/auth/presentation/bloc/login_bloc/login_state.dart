part of 'login_bloc.dart';


abstract class LoginState extends Equatable {}

class UserLoggedIn extends LoginState {
  UserLoggedIn();
  @override
  List<Object?> get props => [];
}

class LogginingInLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoggingInFailureState extends LoginState {
  @override
  List<Object?> get props => [];
}

class NetworkFailureState extends LoginState {
  @override
  List<Object?> get props => [];
}

class UserIdleState extends LoginState {
  @override
  List<Object?> get props => [];
}
