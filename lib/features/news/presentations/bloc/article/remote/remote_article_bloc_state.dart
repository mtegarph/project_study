part of 'remote_article_bloc.dart';

abstract class RemoteArticleBlocState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;

  const RemoteArticleBlocState({this.articles, this.error});

  @override
  List<Object> get props => [articles!, error!];
}

final class RemoteArticleBlocLoading extends RemoteArticleBlocState {
  const RemoteArticleBlocLoading();
}

final class RemoteArticleBlocDone extends RemoteArticleBlocState {
  const RemoteArticleBlocDone(List<ArticleEntity> article)
      : super(articles: article);
}

final class RemoteArticleBlocFailed extends RemoteArticleBlocState {
  const RemoteArticleBlocFailed(DioException error) : super(error: error);
}
