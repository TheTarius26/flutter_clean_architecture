import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/src/core/params/article_params.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';
import 'package:clean_architecture/src/domain/usecases/get_saved_articles_use_case.dart';
import 'package:clean_architecture/src/domain/usecases/remove_article_use_case.dart';
import 'package:clean_architecture/src/domain/usecases/save_article_use_case.dart';
import 'package:equatable/equatable.dart';

part 'local_articles_event.dart';
part 'local_articles_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  LocalArticlesBloc(
    GetSavedArticlesUseCase getSavedArticlesUseCase,
    SaveArticleUseCase saveArticleUseCase,
    RemoveArticleUseCase removeArticleUseCase,
  )   : _getSavedArticlesUseCase = getSavedArticlesUseCase,
        _saveArticleUseCase = saveArticleUseCase,
        _removeArticleUseCase = removeArticleUseCase,
        super(const LocalArticlesLoading()) {
    on<GetAllSavedArticles>(_onGetAllSavedArticles);
    on<SaveArticle>(_onSaveArticle);
    on<RemoveArticle>(_onRemoveArticle);
  }

  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;

  FutureOr<void> _onGetAllSavedArticles(
    GetAllSavedArticles event,
    Emitter<LocalArticlesState> emit,
  ) async {
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticlesDone(articles: articles));
  }

  FutureOr<void> _onSaveArticle(
    SaveArticle event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(const LocalArticlesLoading());
    await _saveArticleUseCase(params: ArticleParams(article: event.article!));
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticlesDone(articles: articles));
  }

  FutureOr<void> _onRemoveArticle(
    RemoveArticle event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(const LocalArticlesLoading());
    await _removeArticleUseCase(params: ArticleParams(article: event.article!));
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticlesDone(articles: articles));
  }
}
