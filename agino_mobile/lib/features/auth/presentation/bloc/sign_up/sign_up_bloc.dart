import 'package:agino_mobile/core/usecase/usecase.dart';
import 'package:agino_mobile/features/auth/domain/usecases/cache_user_usecase.dart';
import 'package:agino_mobile/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final CacheUserUsecase cacheUserUsecase;
  final GetCachedUserUsecase getCachedUserUsecase;

  SignUpBloc(
      {required this.cacheUserUsecase, required this.getCachedUserUsecase})
      : super(UserIdleState()) {
    on<CacheSignUpEvent>(_onCacheSignUp);
    on<GetCachedUserEvent>(_onGetCachedUser);
  }

  Future<void> _onCacheSignUp(
      CacheSignUpEvent event, Emitter<SignUpState> emit) async {
    emit(UserIdleState());
    final res = await cacheUserUsecase(event.user);
    res.fold((l) {
      return emit(UserCachingFailureState());
    }, (r) {
      return emit(UserCachingSuccessfulState());
    });
  }

  Future<void> _onGetCachedUser(
      GetCachedUserEvent event, Emitter<SignUpState> emit) async {
    emit(UserIdleState());
    final res = await getCachedUserUsecase(NoParams());
    res.fold((l) {
      return emit(UserCachingFailureState());
    }, (r) {
      return emit(UserLoadedState(user: r));
    });
  }
}
