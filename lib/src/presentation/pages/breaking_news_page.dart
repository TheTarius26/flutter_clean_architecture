import 'package:clean_architecture/src/core/bloc/bloc_with_state.dart';
import 'package:clean_architecture/src/domain/entities/article.dart';
import 'package:clean_architecture/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
import 'package:clean_architecture/src/presentation/widgets/article_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

class BreakingNewsPage extends HookWidget {
  const BreakingNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(
      () {
        scrollController.addListener(
          () => _onScrollListener(context, scrollController),
        );
        return scrollController.dispose;
      },
      [scrollController],
    );

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(scrollController),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Builder(
          builder: (context) => GestureDetector(
            onTap: () => _onShowSavedArticlesViewTapped(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(
                Ionicons.bookmark,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is RemoteArticleError) {
          return Center(
            child: GestureDetector(
              onTap: () => _onRetryTapped(context),
              child: const Icon(Ionicons.refresh),
            ),
          );
        }
        if (state is RemoteArticleDone) {
          return _buildArticle(
            scrollController,
            state.articles ?? [],
            state.noMoreData ?? false,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildArticle(
    ScrollController scrollController,
    List<Article> articles,
    bool noMoreData,
  ) {
    return ListView(
      controller: scrollController,
      children: [
        ...List.from(
          articles.map(
            (article) => Builder(
              builder: (context) {
                return ArticleWidget(
                  article: article,
                  onArticlePressed: (e) => _onArticlePressed(context, e),
                );
              },
            ),
          ),
        ),
        if (noMoreData) ...[
          const SizedBox(),
        ] else ...[
          const Padding(
            padding: EdgeInsets.all(14),
            child: CupertinoActivityIndicator(),
          ),
        ]
      ],
    );
  }

  void _onScrollListener(
    BuildContext context,
    ScrollController scrollController,
  ) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final remoteArticleBloc = context.read<RemoteArticlesBloc>();
    final state = remoteArticleBloc.blocProcessState;

    if (currentScroll == maxScroll && state == BlocProcessState.idle) {
      remoteArticleBloc.add(const GetArticles());
    }
  }

  void _onArticlePressed(BuildContext context, Article article) {
    Navigator.of(context).pushNamed(
      '/ArticleDetailsView',
      arguments: article,
    );
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticlesView');
  }

  void _onRetryTapped(BuildContext context) {
    context.read<RemoteArticlesBloc>().add(const GetArticles());
  }
}
