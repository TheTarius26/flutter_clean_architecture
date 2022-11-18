import 'package:clean_architecture/src/core/params/article_params.dart';
import 'package:clean_architecture/src/core/params/article_request.dart';
import 'package:clean_architecture/src/core/resources/data_state.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';

abstract class ArticlesRepository {
  Future<DataState<List<Article>>> getBreakingNewsArticles(
    ArticleRequestParams params,
  );

  Future<List<Article>> getSavedArticles();

  Future<void> saveArticle(ArticleParams article);

  Future<void> removeArticle(ArticleParams article);
}
