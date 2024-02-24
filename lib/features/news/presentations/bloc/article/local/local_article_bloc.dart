import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:project_study/features/news/domain/usecases/get_saved_article.dart';
import 'package:project_study/features/news/domain/usecases/remove_article.dart';
import 'package:project_study/features/news/domain/usecases/save_article.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

//untuk pemanggilan use case di bloc bisa dipanggil dari berbagai fitur yang berbeda
class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase getSavedArticleUseCase;
  final SavedArticleUseCase saveArticleUseCase;
  final RemoveArticleUseCase removeArticleUseCase;

  LocalArticleBloc(this.getSavedArticleUseCase, this.saveArticleUseCase,
      this.removeArticleUseCase)
      : super(const LocalArticleLoading()) {
    on<GetSavedArticle>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }
  void onGetSavedArticles(
      GetSavedArticle event, Emitter<LocalArticleState> emit) async {
    final articles = await getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onRemoveArticle(
      RemoveArticle event, Emitter<LocalArticleState> emit) async {
    await removeArticleUseCase(params: event.articleEntity);
    final articles = await getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onSaveArticle(SaveArticle event, Emitter<LocalArticleState> emit) async {
    await saveArticleUseCase(params: event.articleEntity);
    final articles = await getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }
}
