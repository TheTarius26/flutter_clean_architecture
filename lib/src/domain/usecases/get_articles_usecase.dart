import 'package:clean_architecture/src/core/params/article_request.dart';
import 'package:clean_architecture/src/core/resources/data_state.dart';
import 'package:clean_architecture/src/core/usecases/usecase.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';
import 'package:clean_architecture/src/domain/repositories/articles_repository.dart';

class GetArticlesUseCase
    implements UseCase<DataState<List<Article>>, ArticleRequestParams> {
  GetArticlesUseCase(ArticlesRepository articlesRepository)
      : _articlesRepository = articlesRepository;

  final ArticlesRepository _articlesRepository;

  @override
  Future<DataState<List<Article>>> call({
    ArticleRequestParams? params,
  }) {
    return _articlesRepository.getBreakingNewsArticles(params!);
  }
}
