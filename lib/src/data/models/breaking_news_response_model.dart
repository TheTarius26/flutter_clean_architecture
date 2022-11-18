import 'package:clean_architecture/src/data/models/article_model.dart';

class BreakingNewsResponseModel {
  BreakingNewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory BreakingNewsResponseModel.fromJson(Map<String, dynamic> map) {
    return BreakingNewsResponseModel(
      status: map['status'] as String,
      totalResults: map['totalResults'] as int,
      articles: List<ArticleModel>.from(
        (map['articles'] as List<dynamic>).map(
          (dynamic e) => ArticleModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }

  final String status;
  final int totalResults;
  final List<ArticleModel> articles;
}
