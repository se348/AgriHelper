import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/position_entity.dart';
import '../../../domain/usecases/get_position_usecase.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  final GetPositionUsecase getPositionUsecase;

  PositionBloc({required this.getPositionUsecase}) : super(PositionIdle()) {
    on<GetPositionEvent>(_onGetPosition);
  }

  Future<void> _onGetPosition(
      GetPositionEvent event, Emitter<PositionState> emit) async {
    final result = await getPositionUsecase(NoParams());
    emit(PositionLoading());
    result.fold((l) {
      return emit(PositionFailed());
    }, (r) {
      return emit(PositionGotSuccessfully(r));
    });
  }
}
