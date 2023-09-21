// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:project_study/core/constant/constant.dart';
import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/news/data/data_source/local/DAO/app_database.dart';
import 'package:project_study/features/news/data/data_source/remote/news_api_service.dart';
import 'package:project_study/features/news/data/model/article.dart';
import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:project_study/features/news/domain/repository/article_repository.dart';

//in this code the article repository implement is where the repository or
//the function of get data from the data source whether is from remote or local is being impplemented

class ArticleRepositoryImpl implements ArticleRepository {
  final AppDatabase appDatabase;
  final NewsApiService _newsApiService;
  ArticleRepositoryImpl(this._newsApiService, this.appDatabase);
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    final httpResponse = await _newsApiService.getNewsArticle(
        apiKey: newsAPIKey, category: category, country: country);
    try {
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        for (var element in httpResponse.data) {
          print("Title: ${element.title}");
        }
        print(httpResponse.data.length);
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSaveArticle() {
    // TODO: implement getSaveArticle
    return appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity articleEntity) {
    // TODO: implement removeArticle
    return appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(articleEntity));
  }

  @override
  Future<void> saveArticle(ArticleEntity articleEntity) {
    // TODO: implement saveArticle
    return appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(articleEntity));
  }
}
