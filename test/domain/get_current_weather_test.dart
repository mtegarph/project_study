import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:project_study/core/error/failure.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';
import 'package:project_study/features/weather/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  //MockWeatherRepository is a generated mock class which implements the function inside the weather repository
  late MockWeatherRepository mockWeatherRepository;
  //to operate with mockWeatherRepository instance
  //the get Current WeatherUseCase will get a pass in through a constructor
  //Setup Will run before every individual test in SetUp we will instantiate the object
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });
  const testWeatherDetail = WeatherEntity(
    cityName: 'Pamulang',
    main: 'Clouds',
    description: 'scattered clouds"',
    iconCode: '03d',
    temperature: 306.24,
    pressure: 1004,
    humidity: 69,
  );
  const testCityName = "Pamulang";
  group('get current weather from use case', () {
    test('should get current weather detail from the repository', () async {
      //arange
      //to provide some funcionality to the mocked instance of the repositoy
      when(mockWeatherRepository.getCurrentWeather(testCityName))
          .thenAnswer((realInvocation) async => const Right(testWeatherDetail));
      //act steps should cover the main thing to be tested
      //this could be calling a function or method calling a REST API
      final result = await getCurrentWeatherUseCase.execute(testCityName);
      //assert we verified if the unit behaved as expected
      expect(result, const Right(testWeatherDetail));
    });
    test('should fail to get current weather detail from the repository',
        () async {
      //arange
      //to provide some funcionality to the mocked instance of the repositoy
      when(mockWeatherRepository.getCurrentWeather(testCityName)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure("Gagal")));
      //act steps should cover the main thing to be tested
      //this could be calling a function or method calling a REST API
      final result = await getCurrentWeatherUseCase.execute(testCityName);
      //assert we verified if the unit behaved as expected
      expect(result, const Left(ServerFailure("Gagal")));
    });
  });
}
