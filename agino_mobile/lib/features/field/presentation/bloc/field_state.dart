part of 'field_bloc.dart';

abstract class FieldState extends Equatable {}

class FieldIdle extends FieldState {
  @override
  List<Object?> get props => [];
}

class FieldLoading extends FieldState {
  @override
  List<Object?> get props => [];
}

class FieldGotSuccessFuly extends FieldState {
  final FieldEntity fieldEntity;

  FieldGotSuccessFuly(this.fieldEntity);

  @override
  List<Object?> get props => [fieldEntity];
}

class FieldCreated extends FieldState {
  final int id;

  FieldCreated(this.id);

  @override
  List<Object?> get props => [id];
}

class FieldFailed extends FieldState {
  FieldFailed();

  @override
  List<Object?> get props => [];
}
