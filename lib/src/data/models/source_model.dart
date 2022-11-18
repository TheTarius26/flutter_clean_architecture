import 'package:clean_architecture/src/domain/entities/source.dart';

class SourceModel extends Source {
  const SourceModel({
    required super.id,
    required super.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> map) {
    return SourceModel(
      id: map['id'] as String?,
      name: map['name'] as String,
    );
  }
}
