import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:project_study/features/weather/data/models/weather.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'Pamulang',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 306.24,
    pressure: 1004,
    humidity: 69,
  );
  test("should be a subclass of weather entity", () async {
    //assert
    //is just assert because we want to seee if the weatherModel is the subclass of weatherEntitiy or
    //inherit the weatherEntity class
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () {
    //arrage
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    //act

    final result = WeatherModel.fromJson(jsonMap);

    //assert

    expect(result, equals(testWeatherModel));
  });

  // this test if for testing if we have a tojson method
  test('Should return a json map containing proper data', () async {
    // act
      final result = testWeatherModel.toJson();
    //assert

    final expectedJsonMap = {
      'weather': [{
        'main': 'Clouds',
        'description':'scattered clouds',
        'icon':'03d',
      }],
      'main':{
        'temp':306.24,
        'pressure':1004,
        'humidity':69
      },
      'name':'Pamulang'
    };
    expect(result, equals(expectedJsonMap));
  });
}
