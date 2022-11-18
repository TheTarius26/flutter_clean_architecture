part of 'local_articles_bloc.dart';

abstract class LocalArticlesState extends Equatable {
  const LocalArticlesState({
    this.articles = const [],
  });

  final List<Article> articles;

  @override
  List<Object> get props => [articles];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticlesState {
  const LocalArticlesDone({
    required super.articles,
  });
}
