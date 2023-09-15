import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_cached_user_usecase.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LogoutUsecase logoutUsecase;
  final GetCachedUserUsecase getCachedUserUsecase;

  ProfileBloc(this.logoutUsecase, this.getCachedUserUsecase)
      : super(LoggedInIdle()) {
    on<LogoutEvent>(
      (event, emit) async {
        await logoutUsecase(NoParams());
        emit(LoggedOutState());
      },
    );

    on<GetProfile>((event, emit) async {
      final res = await getCachedUserUsecase(NoParams());
      res.fold((l) => null, (r) => emit(LoggedInState(r)));
    });
  }
}
