import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecases/get_cached_user_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';


class SplashBloc extends Bloc<CheckIfLoggedIn, SplashState>{
  final GetCachedUserUsecase getCachedUserUsecase;

  SplashBloc(this.getCachedUserUsecase): super(SplashIdle()){
    on<CheckIfLoggedIn>(_onCheckIfLoggedIn);
  }

  Future<void> _onCheckIfLoggedIn(CheckIfLoggedIn event, Emitter<SplashState> emit) async{
    final res = await getCachedUserUsecase(NoParams());
    res.fold((l){
      return emit(LoggedInState(false));
    }, (r) {
      final token = r.token;
      if (token == null){
        return emit(LoggedInState(false));
      }
      return emit(LoggedInState(true));
    });
  }
}