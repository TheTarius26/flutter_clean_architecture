import 'package:clean_architecture/src/core/utils/constants.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';
import 'package:clean_architecture/src/injector.dart';
import 'package:clean_architecture/src/presentation/blocs/local_articles/local_articles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ArticleDetailsPage extends HookWidget {
  const ArticleDetailsPage({super.key, required this.article});

  final Article article;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalArticlesBloc>(
      create: (context) => injector()..add(const GetAllSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onBackButtonTapped(context),
            child: const Icon(
              Ionicons.chevron_back,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    final localDate = DateTime.parse(article.publishedAt);
    final dateAndTime = localDate.toString().split('.').first;
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16),
              const SizedBox(width: 4),
              Text(
                dateAndTime,
                style: const TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Hero(
      tag: '${kBreakingNewsHeroTag}_${article.id}_${article.url}',
      child: Container(
        width: double.maxFinite,
        height: 250,
        margin: const EdgeInsets.only(top: 14),
        child: Image.network(
          article.urlToImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Text('Error loading image'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${article.description}\n\n${article.content}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonTapped(context),
        child: const Icon(
          Ionicons.bookmark,
          color: Colors.white,
        ),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonTapped(BuildContext context) {
    context.read<LocalArticlesBloc>().add(SaveArticle(article: article));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully'),
      ),
    );
  }
}
