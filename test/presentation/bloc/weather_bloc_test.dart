import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_study/core/error/failure.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';
import 'package:project_study/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc =
        WeatherBloc(getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase);
  });
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

  group("bloc test", () {
    test('Initial State shoulb be empty', () {
      expect(weatherBloc.state, WeatherInitial());
    });
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when MyEvent is added.',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(cityName)).thenAnswer(
            (realInvocation) async => const Right(testWeatherEntity));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(cityName: cityName)),
      expect: () => <WeatherState>[
        WeatherLoading(),
        const WeatherLoaded(result: testWeatherEntity)
      ],
      wait: const Duration(milliseconds: 500),
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoadFailuer] when MyEvent is added.',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(cityName)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(cityName: cityName)),
      expect: () => <WeatherState>[
        WeatherLoading(),
        const WeatherLoadFailuer(message: 'server failure')
      ],
      wait: const Duration(milliseconds: 500),
    );
  });
}
