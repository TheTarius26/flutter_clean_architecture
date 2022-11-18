import 'package:clean_architecture/src/domain/entities/article.dart';
import 'package:clean_architecture/src/presentation/pages/article_details_page.dart';
import 'package:clean_architecture/src/presentation/pages/breaking_news_page.dart';
import 'package:clean_architecture/src/presentation/pages/saved_articles_page.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String home = '/';
  static const String articleDetail = '/ArticleDetailsView';
  static const String savedArticles = '/SavedArticlesView';

  static Route<Widget>? onGenerateRoute(RouteSettings settings) {
    MaterialPageRoute<Widget> builder(Widget child) {
      return MaterialPageRoute(
        builder: (_) => child,
        settings: settings,
      );
    }

    switch (settings.name) {
      case home:
        return builder(const BreakingNewsPage());
      case articleDetail:
        return builder(
          ArticleDetailsPage(article: settings.arguments! as Article),
        );
      case savedArticles:
        return builder(const SavedArticlesPage());
      default:
        return null;
    }
  }
}
