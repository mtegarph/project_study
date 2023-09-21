import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/core/usecases/usecase.dart';
import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:project_study/features/news/domain/repository/article_repository.dart';

// the use case file is for the execution the get data from a remote or local and
//the basic method of a usecase function is called call
class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository articleRepository;

  GetArticleUseCase(this.articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return articleRepository.getNewsArticle();
  }
}
