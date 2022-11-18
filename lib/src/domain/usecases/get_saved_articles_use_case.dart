import 'package:clean_architecture/src/core/usecases/usecase.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';
import 'package:clean_architecture/src/domain/repositories/articles_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<Article>, void> {
  GetSavedArticlesUseCase(ArticlesRepository articlesRepository)
      : _articlesRepository = articlesRepository;

  final ArticlesRepository _articlesRepository;

  @override
  Future<List<Article>> call({void params}) {
    return _articlesRepository.getSavedArticles();
  }
}
