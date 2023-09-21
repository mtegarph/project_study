
import 'package:project_study/core/usecases/usecase.dart';
import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:project_study/features/news/domain/repository/article_repository.dart';

// the use case file is for the execution the get data from a remote or local and
//the basic method of a usecase function is called call
class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository articleRepository;

  GetSavedArticleUseCase(this.articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return articleRepository.getSaveArticle();
  }
}
