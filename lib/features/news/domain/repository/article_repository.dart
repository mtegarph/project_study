import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/news/domain/entities/article.dart';

abstract class ArticleRepository {
  //API Method
  Future<DataState<List<ArticleEntity>>> getNewsArticle();

  //Database Method
  Future<List<ArticleEntity>> getSaveArticle();

  Future<void> saveArticle(ArticleEntity articleEntity);

  Future<void> removeArticle(ArticleEntity articleEntity);
}
