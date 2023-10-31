import 'package:mockito/annotations.dart';
import 'package:project_study/features/weather/data/datasources/remote/weather_remote_data_sources.dart';
import 'package:project_study/features/weather/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:project_study/features/weather/domain/usecases/get_current_weather.dart';

@GenerateMocks(
  [WeatherRepository, WeatherRemoteDataSource, GetCurrentWeatherUseCase],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
