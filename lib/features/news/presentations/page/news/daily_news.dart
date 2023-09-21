import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:project_study/features/news/presentations/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_study/features/news/presentations/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Daily News',
        style: GoogleFonts.aboreto(
            color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBlocBloc, RemoteArticleBlocState>(
      builder: (context, state) {
        if (state is RemoteArticleBlocLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is RemoteArticleBlocFailed) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }
        if (state is RemoteArticleBlocDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.articles?[index],
                onArticlePressed: (article) =>
                    _onArticlePressed(context, state.articles![index]),
              );
            },
            itemCount: state.articles!.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
