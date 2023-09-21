import 'package:floor/floor.dart';
import 'package:project_study/features/news/data/model/article.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel articleModel);
  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query("SELECT * FROM article")
  Future<List<ArticleModel>> getArticles();
}
