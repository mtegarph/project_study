import 'package:dartz/dartz.dart';
import 'package:project_study/core/error/failure.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  //either is the class to handle error it has two generic parameter name right and left
  //in right we set the value that we want to return if the operation is successful
  // in left we set the value that we want to return if the operation is failed
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
