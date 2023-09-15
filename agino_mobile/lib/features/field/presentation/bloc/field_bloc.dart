import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/field_entity.dart';
import '../../domain/usecases/create_field_usecase.dart';
import '../../domain/usecases/get_field_usecase.dart';

part 'field_event.dart';
part 'field_state.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  final CreateFieldUsecase createFieldUsecase;
  final GetFieldUsecase getFieldUsecase;
  FieldBloc({required this.createFieldUsecase, required this.getFieldUsecase}) : super(FieldIdle()) {
    on<CreateFieldEvent>(_onCreateFieldEvent);
    on<GetFieldEvent>(_onGetFieldEvent);
  }

  Future<void> _onCreateFieldEvent(
      CreateFieldEvent event, Emitter<FieldState> emit) async {
    emit(FieldLoading());
    final res = await createFieldUsecase(event.fieldEntity);

    res.fold((l) {
      if (l is NetworkFailure) {
        return emit(FieldFailed());
      }
      return emit(FieldFailed());
    }, (r) {
      return emit(FieldCreated(r));
    });
  }
  Future<void> _onGetFieldEvent(GetFieldEvent event, Emitter<FieldState> emit) async{
    emit(FieldLoading());
    final res = await getFieldUsecase(event.fieldId);
     res.fold((l) {
      if (l is NetworkFailure) {
        return emit(FieldFailed());
      }
      return emit(FieldFailed());
    }, (r) {
      return emit(FieldGotSuccessFuly(r));
    });
  }
}
