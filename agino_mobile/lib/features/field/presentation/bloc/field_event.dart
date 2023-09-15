part of 'field_bloc.dart';

abstract class FieldEvent extends Equatable {}

class CreateFieldEvent extends FieldEvent {
  final FieldEntity fieldEntity;
  CreateFieldEvent({required this.fieldEntity});

  @override
  List<Object?> get props => [fieldEntity];
}

class GetFieldEvent extends FieldEvent{
  final int fieldId;
  GetFieldEvent({required this.fieldId});
  
  @override
  List<Object?> get props => [fieldId];
}