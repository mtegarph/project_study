part of 'local_article_bloc.dart';

abstract class LocalArticleEvent extends Equatable {
  final ArticleEntity? articleEntity;
  const LocalArticleEvent({this.articleEntity});

  @override
  List<Object> get props => [articleEntity!];
}

class GetSavedArticle extends LocalArticleEvent {
  const GetSavedArticle();
}

class RemoveArticle extends LocalArticleEvent {
  const RemoveArticle(ArticleEntity articleEntity)
      : super(articleEntity: articleEntity);
}

class SaveArticle extends LocalArticleEvent {
  const SaveArticle(ArticleEntity articleEntity)
      : super(articleEntity: articleEntity);
}
