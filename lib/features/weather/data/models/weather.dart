import 'package:project_study/features/weather/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required String cityName,
      required String main,
      required String description,
      required String iconCode,
      required double temperature,
      required int pressure,
      required int humidity})
      : super(
            cityName: cityName,
            description: description,
            humidity: humidity,
            iconCode: iconCode,
            main: main,
            pressure: pressure,
            temperature: temperature);

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      cityName: json["name"],
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      main: json['weather'][0]['main'],
      pressure: json['main']['pressure'],
      temperature: json['main']['temp']);

  Map<String, dynamic> toJson() => {
        'weather': [
          {'main': main, 'description': description, 'icon': iconCode},
        ],
        'main': {
          'temp': temperature,
          'pressure': pressure,
          'humidity': humidity,
        },
        'name': cityName,
      };

  WeatherEntity toEntity() => WeatherEntity(
      cityName: cityName,
      main: main,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
      pressure: pressure,
      humidity: humidity);
}
