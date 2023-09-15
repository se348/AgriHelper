part of 'login_bloc.dart';
abstract class LoginEvent extends Equatable {}

class RemoteLoginEvent extends LoginEvent {
  final LoginEntity user;
  RemoteLoginEvent({required this.user});
  @override
  List<Object?> get props => [user];
}