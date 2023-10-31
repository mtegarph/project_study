import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_study/core/error/exception.dart';
import 'package:project_study/core/error/failure.dart';
import 'package:project_study/features/weather/data/models/weather.dart';
import 'package:project_study/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  //we need to access data source so we need generate a mock for the weather remote data
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'Pamulang',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 306.24,
    pressure: 1004,
    humidity: 69,
  );
  const testWeatherEntity = WeatherEntity(
    cityName: 'Pamulang',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 306.24,
    pressure: 1004,
    humidity: 69,
  );
  const cityName = 'Pamulang';
  group("calling api current weather", () {
    test('should return weather when a call to data source is successful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
          .thenAnswer((realInvocation) async => testWeatherModel);
      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(cityName);
      //assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
          .thenThrow(ServerException());
      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(cityName);
      //assert
      expect(result, equals(const Left(ServerFailure("An Error Has Occured"))));
    });

    test('should return server failure when the device has not internet',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
          .thenThrow(const SocketException('failed to connect to the network'));
      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(cityName);
      //assert
      expect(
          result,
          equals(
              const Left(ConnectionFailure("failed to connect to the network"))));
    });
  });
}
