import 'package:mockito/annotations.dart';
import 'package:project_study/features/history/data/datasources/remote/history_api_services.dart';
import 'package:project_study/features/history/domain/repositories/history_reporitory.dart';
import 'package:project_study/features/history/domain/usecases/get_history.dart';
import 'package:project_study/features/weather/data/datasources/remote/weather_remote_data_sources.dart';
import 'package:project_study/features/weather/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:project_study/features/weather/domain/usecases/get_current_weather.dart';
import 'package:dio/dio.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    HistorApiServices,
    GetCurrentWeatherUseCase,
    // GetHistoryUseCase,
    HistoryRepository
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
    //MockSpec<HistoryRepository>()
  ],
)
void main() {}
