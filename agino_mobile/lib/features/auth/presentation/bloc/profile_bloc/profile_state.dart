part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class LoggedInIdle extends ProfileState{
  @override
  List<Object?> get props => [];

}

class LoggedInState extends ProfileState {
  final User user;

  LoggedInState(this.user);

  @override
  List<Object?> get props => [user];
}



class LoggedOutState extends ProfileState {
  @override
  List<Object?> get props => [];
}
