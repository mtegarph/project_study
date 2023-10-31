import 'package:get_it/get_it.dart';
import 'package:project_study/features/dashboard/data/data_source/remote/product_api_service.dart';
import 'package:project_study/features/dashboard/data/repository/product_repository.dart';
import 'package:project_study/features/dashboard/domain/repositories/product_repository.dart';
import 'package:project_study/features/dashboard/domain/usecase/get_product.dart';
import 'package:project_study/features/dashboard/presentation/bloc/product/remote/remote_product_bloc.dart';
import 'package:project_study/features/history/data/datasources/remote/history_api_services.dart';
import 'package:project_study/features/history/data/repositories/history_repository.dart';
import 'package:project_study/features/history/domain/repositories/history_reporitory.dart';
import 'package:project_study/features/history/domain/usecases/get_history.dart';
import 'package:project_study/features/history/presentation/bloc/history_bloc.dart';
import 'package:project_study/features/news/data/data_source/local/DAO/app_database.dart';
import 'package:project_study/features/news/data/data_source/remote/news_api_service.dart';
import 'package:dio/dio.dart';
import 'package:project_study/features/news/data/repository/article_repository.dart';
import 'package:project_study/features/news/domain/repository/article_repository.dart';
import 'package:project_study/features/news/domain/usecases/get_article.dart';
import 'package:project_study/features/news/domain/usecases/get_saved_article.dart';
import 'package:project_study/features/news/domain/usecases/remove_article.dart';
import 'package:project_study/features/news/domain/usecases/save_article.dart';
import 'package:project_study/features/news/presentations/bloc/article/local/local_article_bloc.dart';
import 'package:project_study/features/news/presentations/bloc/article/remote/remote_article_bloc.dart';
import 'package:project_study/features/weather/data/datasources/remote/weather_remote_data_sources.dart';
import 'package:project_study/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:project_study/features/weather/domain/repositories/weather_repository.dart';
import 'package:project_study/features/weather/domain/usecases/get_current_weather.dart';
import 'package:project_study/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
//the registerSingleton is for initilaize a funciont that will be initialize once and can be use anywhere
//the different between lazysingleton and singleton is tha singleton is always registered immediately after the app starts
//while lazy singleton is registered only when its requested as a dependency for som other class
Future<void> initializeDependencies() async {
  //floor database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  //dio
  sl.registerSingleton<Dio>(Dio());

  //http
  sl.registerLazySingleton(() => http.Client());

  //data source
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));

  //dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ProductApiService>(ProductApiService(sl()));
  sl.registerSingleton<HistorApiServices>(HistorApiServices(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(sl()));
  sl.registerSingleton<HistoryRepository>(HistoryRepositoryImpl(sl()));
  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: sl()));

  //usecase
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerSingleton<SavedArticleUseCase>(SavedArticleUseCase(sl()));

  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  sl.registerSingleton<GetProductUseCase>(GetProductUseCase(sl()));
  sl.registerSingleton<GetHistoryUseCase>(GetHistoryUseCase(sl()));

  sl.registerLazySingleton(() => GetCurrentWeatherUseCase(sl()));

  //bloc
  // a function of the registerFactory it can register more than once
  sl.registerFactory<RemoteArticleBlocBloc>(() => RemoteArticleBlocBloc(sl()));
  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));
  sl.registerFactory<RemoteProductBloc>(() => RemoteProductBloc(sl()));
  sl.registerFactory<HistoryBloc>(() => HistoryBloc(sl()));
  sl.registerFactory<WeatherBloc>(
      () => WeatherBloc(getCurrentWeatherUseCase: sl()));
}
