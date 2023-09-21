part of 'remote_article_bloc.dart';

abstract class RemoteArticleBlocEvent extends Equatable {
  const RemoteArticleBlocEvent();

  @override
  List<Object> get props => [];
}

class GetArticles extends RemoteArticleBlocEvent {
  const GetArticles();
}
