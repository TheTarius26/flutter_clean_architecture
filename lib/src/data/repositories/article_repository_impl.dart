import 'dart:io';

import 'package:clean_architecture/src/core/params/article_params.dart';
import 'package:clean_architecture/src/core/params/article_request.dart';
import 'package:clean_architecture/src/core/resources/data_state.dart';
import 'package:clean_architecture/src/data/datasources/local/app_database.dart';
import 'package:clean_architecture/src/data/datasources/remote/news_api_service.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';
import 'package:clean_architecture/src/domain/repositories/articles_repository.dart';
import 'package:dio/dio.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  const ArticlesRepositoryImpl(
    NewsApiService newsApiService,
    AppDatabase appDatabase,
  )   : _newsApiService = newsApiService,
        _appDatabase = appDatabase;

  final NewsApiService _newsApiService;

  final AppDatabase _appDatabase;

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticles(
    ArticleRequestParams params,
  ) async {
    try {
      final httpResponse = await _newsApiService.getBreakingNewsArticle(
        apiKey: params.apiKey,
        country: params.country,
        category: params.category,
        page: params.page,
        pageSize: params.pageSize,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles);
      }
      return DataError(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<List<Article>> getSavedArticles() {
    return _appDatabase.articleDao.getAllArticle();
  }

  @override
  Future<void> removeArticle(ArticleParams params) {
    return _appDatabase.articleDao.deleteArticle(params.article);
  }

  @override
  Future<void> saveArticle(ArticleParams params) {
    return _appDatabase.articleDao.insertArticle(params.article);
  }
}
