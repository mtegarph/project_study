import 'package:dartz/dartz.dart';
import 'package:project_study/core/error/failure.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';
import 'package:project_study/features/weather/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
