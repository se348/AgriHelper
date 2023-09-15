part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {}

class UserLoadedState extends SignUpState {
  final User user;
  UserLoadedState({required this.user});
  @override
  List<Object?> get props => [user];
}

class UserCachingSuccessfulState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class UserCachingFailureState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class NetworkFailureState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class RegisteredSuccessfulState extends SignUpState{
  @override
  List<Object?> get props => [];
}

class SignUpFailedState extends SignUpState{
  @override
  List<Object?> get props => [];
}

class ServerFailureState extends SignUpState{
  @override
  List<Object?> get props => [];
}

class UserIdleState extends SignUpState {
  @override
  List<Object?> get props => [];
}
