import 'package:clean_architecture/src/core/params/article_params.dart';
import 'package:clean_architecture/src/core/usecases/usecase.dart';
import 'package:clean_architecture/src/domain/repositories/articles_repository.dart';

class SaveArticleUseCase implements UseCase<void, ArticleParams> {
  SaveArticleUseCase(ArticlesRepository articlesRepository)
      : _articlesRepository = articlesRepository;

  final ArticlesRepository _articlesRepository;

  @override
  Future<void> call({ArticleParams? params}) {
    return _articlesRepository.saveArticle(params!);
  }
}
