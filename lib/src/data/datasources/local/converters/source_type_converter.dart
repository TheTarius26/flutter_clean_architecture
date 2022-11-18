import 'package:clean_architecture/src/domain/entities/source.dart';
import 'package:floor/floor.dart';

class SourceTypeConverter extends TypeConverter<Source, String> {
  @override
  Source decode(String databaseValue) {
    final results = databaseValue.split(',');
    return Source(
      id: results.first,
      name: results.last,
    );
  }

  @override
  String encode(Source value) {
    final result = '${value.id},${value.name}';
    return result;
  }
}
