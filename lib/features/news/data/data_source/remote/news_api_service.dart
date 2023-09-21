import 'package:project_study/core/constant/constant.dart';
import 'package:project_study/features/news/data/model/article.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
part 'news_api_service.g.dart';

// in this class we are using retrofit for generate a function to call an api

// the @RestApi is for the decralation to the retrofit that we want to generate a function for restApi
@RestApi(baseUrl: newsApiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;
  // the @GET annotation is for the function to know that what we want to generate is a Get function or other function
  @GET("/top-headlines")
  Future<HttpResponse<List<ArticleModel>>> getNewsArticle({
    // and the @Query annotation is for giving the function a parameter to the api if the api has a parameter in it
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}
