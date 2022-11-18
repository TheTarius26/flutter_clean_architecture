// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_architecture/src/data/models/source_model.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    super.id,
    required super.source,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.content,
    required super.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      source: SourceModel.fromJson(map['source'] as Map<String, dynamic>),
      author: map['author'] as String? ?? '',
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      url: map['url'] as String,
      urlToImage: map['urlToImage'] as String? ?? '',
      content: map['content'] as String? ?? '',
      publishedAt: map['publishedAt'] as String,
    );
  }
}
