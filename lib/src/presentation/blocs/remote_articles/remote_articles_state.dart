part of 'remote_articles_bloc.dart';

abstract class RemoteArticlesState extends Equatable {
  const RemoteArticlesState({
    this.articles,
    this.noMoreData,
    this.error,
  });

  final List<Article>? articles;
  final bool? noMoreData;

  final DioError? error;

  @override
  List<Object> get props => [
        articles ?? 'null',
        noMoreData ?? 'null',
        error ?? 'null',
      ];
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

class RemoteArticleDone extends RemoteArticlesState {
  const RemoteArticleDone(
    List<Article> article, {
    super.noMoreData,
  }) : super(
          articles: article,
        );
}

class RemoteArticleError extends RemoteArticlesState {
  const RemoteArticleError(DioError error) : super(error: error);
}
