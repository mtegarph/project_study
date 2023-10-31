part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded({required this.result});

  @override
  List<Object?> get props => [result];
}

class WeatherLoadFailuer extends WeatherState {
  final String message;

  const WeatherLoadFailuer({required this.message});

  @override
  List<Object?> get props => [message];
}
