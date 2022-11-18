import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/src/core/bloc/bloc_with_state.dart';
import 'package:clean_architecture/src/core/params/article_request.dart';
import 'package:clean_architecture/src/core/resources/data_state.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';
import 'package:clean_architecture/src/domain/usecases/get_articles_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_articles_event.dart';
part 'remote_articles_state.dart';

class RemoteArticlesBloc
    extends BlocWithState<RemoteArticlesEvent, RemoteArticlesState> {
  RemoteArticlesBloc(GetArticlesUseCase getArticlesUseCase)
      : _getArticlesUseCase = getArticlesUseCase,
        super(const RemoteArticlesLoading()) {
    on<GetArticles>(_onGetArticles);
  }

  final GetArticlesUseCase _getArticlesUseCase;

  final List<Article> _articles = [];
  int _page = 1;
  static const int _pageSize = 20;

  FutureOr<void> _onGetArticles(
    GetArticles event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    emit(const RemoteArticlesLoading());
    final dataState = await _getArticlesUseCase(
      params: ArticleRequestParams(page: _page),
    );

    if (dataState is DataSuccess && dataState.data != null) {
      final articles = dataState.data!;
      final noMoreData = articles.length < _pageSize;
      _articles.addAll(articles);
      _page++;

      emit(RemoteArticleDone(_articles, noMoreData: noMoreData));
    }
    if (dataState is DataError) {
      emit(RemoteArticleError(dataState.error!));
    }
  }
}
