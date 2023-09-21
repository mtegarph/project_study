import 'package:floor/floor.dart';
import 'package:project_study/features/news/data/data_source/local/DAO/article_dao.dart';
import 'package:project_study/features/news/data/model/article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
