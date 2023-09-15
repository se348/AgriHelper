part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {}

class SplashIdle extends SplashState {
  @override
  List<Object?> get props => [];
}

class LoggedInState extends SplashState {
  final bool state;

  LoggedInState(this.state);
  @override
  List<Object?> get props => [state];
}

class CheckingFailedState extends SplashState {
  @override
  List<Object?> get props => [];
}
