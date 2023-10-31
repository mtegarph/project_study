import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_study/core/constant/constant.dart';
import 'package:project_study/core/error/exception.dart';
import 'package:project_study/features/weather/data/datasources/remote/weather_remote_data_sources.dart';
import 'package:http/http.dart' as http;
import 'package:project_study/features/weather/data/models/weather.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  const cityName = 'Pamulang';
  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });
  //stubbing mean returning a fake object when the mock method is called
  group('Get Current Weather', () {
    test('should return weather model when the response is 200', () async {
      //arrange
      //in this method when, we mock the get of http api and the data using stubbing so
      //that we can check if the method is working properly
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(cityName))))
          .thenAnswer((realInvocation) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));
      //act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(cityName);
      //assert

      expect(result, isA<WeatherModel>());
    });
    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        //arrange
        //in this method when, we mock the get of http api and the data using stubbing so
        //that we can check if the method is working properly
        when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(cityName))))
            .thenAnswer(
                (realInvocation) async => http.Response('not found', 404));
        //act
        final call = weatherRemoteDataSourceImpl.getCurrentWeather;
        //assert
        expect(() => call(cityName), throwsA(isA<ServerException>()));
      },
    );
  });
}
