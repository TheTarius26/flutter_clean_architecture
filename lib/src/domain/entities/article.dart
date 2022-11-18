import 'package:clean_architecture/src/core/utils/constants.dart';
import 'package:clean_architecture/src/domain/entities/source.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: kArticlesTableName)
class Article extends Equatable {
  const Article({
    this.id,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.publishedAt,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;
  final String publishedAt;

  @override
  List<Object?> get props => [
        id,
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        content,
        publishedAt,
      ];

  @override
  bool? get stringify => true;
}
