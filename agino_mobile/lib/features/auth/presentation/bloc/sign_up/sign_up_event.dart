part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {}

class RemoteSignUpEvent extends SignUpEvent {
  final User user;
  RemoteSignUpEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class CacheSignUpEvent extends SignUpEvent {
  final User user;
  CacheSignUpEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class GetCachedUserEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}
