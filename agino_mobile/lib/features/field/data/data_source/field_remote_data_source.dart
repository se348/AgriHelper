import '../models/field_model.dart';

abstract class FieldRemoteDataSource {
  Future<int> createField(FieldModel fieldModel);
  Future<FieldModel> getField(int fieldId);
}
