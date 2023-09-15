import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecases/cache_user_usecase.dart';
import '../../../domain/usecases/get_cached_user_usecase.dart';
import '../../../domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final CacheUserUsecase cacheUserUsecase;
  final GetCachedUserUsecase getCachedUserUsecase;
  final SignUpUsecase signUpUsecase;
  SignUpBloc(
      {required this.cacheUserUsecase, required this.getCachedUserUsecase, required this.signUpUsecase})
      : super(UserIdleState()) {
    on<CacheSignUpEvent>(_onCacheSignUp);
    on<GetCachedUserEvent>(_onGetCachedUser);
    on<RemoteSignUpEvent>(_onSignUp);
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

  Future<void> _onSignUp(RemoteSignUpEvent event, Emitter<SignUpState> emit) async{
    emit(UserLoadingState());
    final res = await signUpUsecase(event.user);
     res.fold((l) {
      if (l is NetworkFailure){
        return emit(NetworkFailureState());
      }
      if(l is SignUpFailure){
        return emit(SignUpFailedState());
      }
      return emit(ServerFailureState());
    }, (r) {
      return emit(RegisteredSuccessfulState());
    });
  }
}
