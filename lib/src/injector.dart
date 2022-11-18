import 'package:clean_architecture/src/core/utils/constants.dart';
import 'package:clean_architecture/src/data/datasources/local/app_database.dart';
import 'package:clean_architecture/src/data/datasources/remote/news_api_service.dart';
import 'package:clean_architecture/src/data/repositories/article_repository_impl.dart';
import 'package:clean_architecture/src/domain/repositories/articles_repository.dart';
import 'package:clean_architecture/src/domain/usecases/get_articles_usecase.dart';
import 'package:clean_architecture/src/domain/usecases/get_saved_articles_use_case.dart';
import 'package:clean_architecture/src/domain/usecases/remove_article_use_case.dart';
import 'package:clean_architecture/src/domain/usecases/save_article_use_case.dart';
import 'package:clean_architecture/src/presentation/blocs/local_articles/local_articles_bloc.dart';
import 'package:clean_architecture/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();

  injector
    ..registerSingleton(database)
    ..registerSingleton(Dio())
    ..registerSingleton(NewsApiService(injector()))
    ..registerSingleton<ArticlesRepository>(
        ArticlesRepositoryImpl(injector(), injector()))
    ..registerSingleton(GetArticlesUseCase(injector()))
    ..registerSingleton(GetSavedArticlesUseCase(injector()))
    ..registerSingleton(RemoveArticleUseCase(injector()))
    ..registerSingleton(SaveArticleUseCase(injector()))
    ..registerFactory(
      () => RemoteArticlesBloc(injector()),
    )
    ..registerFactory(
      () => LocalArticlesBloc(injector(), injector(), injector()),
    );
}
