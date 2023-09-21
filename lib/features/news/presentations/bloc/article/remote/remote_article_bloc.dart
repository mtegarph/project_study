import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_study/core/resource/data_state.dart';

import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:dio/dio.dart';
import 'package:project_study/features/news/domain/usecases/get_article.dart';

part 'remote_article_bloc_event.dart';
part 'remote_article_bloc_state.dart';

class RemoteArticleBlocBloc
    extends Bloc<RemoteArticleBlocEvent, RemoteArticleBlocState> {
  final GetArticleUseCase getArticleUseCase;
  RemoteArticleBlocBloc(this.getArticleUseCase)
      : super(const RemoteArticleBlocLoading()) {
    on<GetArticles>(onGetArticles);
  }
  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleBlocState> emit) async {
    final dataState = await getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleBlocDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteArticleBlocFailed(dataState.error!));
    }
  }
}
