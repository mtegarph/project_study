import 'package:project_study/core/usecases/usecase.dart';
import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:project_study/features/news/domain/repository/article_repository.dart';

// the use case file is for the execution the get data from a remote or local and
//the basic method of a usecase function is called call
class SavedArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository articleRepository;

  SavedArticleUseCase(this.articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return articleRepository.saveArticle(params!);
  }
}
