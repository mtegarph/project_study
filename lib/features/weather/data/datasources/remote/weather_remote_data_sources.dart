import 'dart:convert';

import 'package:project_study/core/constant/constant.dart';
import 'package:project_study/core/error/exception.dart';
import 'package:project_study/core/error/failure.dart';
import 'package:project_study/features/weather/data/models/weather.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});
  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    // TODO: implement getCurrentWeather
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
