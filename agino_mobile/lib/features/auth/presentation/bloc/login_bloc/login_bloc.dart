import '../../../domain/entities/login_entity.dart';
import '../../../domain/usecases/login_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase loginUserUsecase;

  LoginBloc(this.loginUserUsecase) : super(UserIdleState()) {
    on<RemoteLoginEvent>(_onRemoteLoginEvent);
  }

  Future<void> _onRemoteLoginEvent(
      RemoteLoginEvent event, Emitter<LoginState> emit) async {
    emit(LogginingInLoadingState());
    final res = await loginUserUsecase(event.user);
    res.fold((l) {
      if (l is NetworkFailure) {
        return emit(NetworkFailureState());
      }
      if (l is LoggingInFailureState) {
        return emit(LoggingInFailureState());
      }
      return emit(LoggingInFailureState());
    }, (r) {
      return emit(UserLoggedIn());
    });
  }
}
