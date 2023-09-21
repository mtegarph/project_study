import 'package:project_study/core/usecases/usecase.dart';
import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:project_study/features/news/domain/repository/article_repository.dart';

// the use case file is for the execution the get data from a remote or local and
//the basic method of a usecase function is called call
class RemoveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository articleRepository;

  RemoveArticleUseCase(this.articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return articleRepository.removeArticle(params!);
  }
}
