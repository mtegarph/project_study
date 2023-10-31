import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:project_study/core/error/exception.dart';
import 'package:project_study/core/error/failure.dart';
import 'package:project_study/features/weather/data/datasources/remote/weather_remote_data_sources.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';
import 'package:project_study/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("An Error Has Occured"));
    } on SocketException {
      return const Left(ConnectionFailure("failed to connect to the network"));
    }
  }
}
