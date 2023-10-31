import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';
import 'package:project_study/features/weather/domain/usecases/get_current_weather.dart';
import 'package:rxdart/rxdart.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  WeatherBloc({required this.getCurrentWeatherUseCase})
      : super(WeatherInitial()) {
    on<OnCityChanged>(_getweatherData,
        transformer: debounce(const Duration(milliseconds: 500)));
  }
  void _getweatherData(OnCityChanged event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final result = await getCurrentWeatherUseCase.execute(event.cityName);
    //fold method from either is to determine if there is a problem in getting the data or not
    result.fold((l) => emit(WeatherLoadFailuer(message: l.message)),
        (r) => emit(WeatherLoaded(result: r)));
  }
}

//Transformer dictate how your event will be proccess within the bloc. it can help reduce boilerplate code
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

// class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
//   final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
//   late final StreamController<OnCityChanged> _cityChangedController;

//   WeatherBloc({required this.getCurrentWeatherUseCase})
//       : super(WeatherInitial()) {
//     _cityChangedController = StreamController<OnCityChanged>();
//     _cityChangedController.stream
//         .debounceTime(const Duration(milliseconds: 500))
//         .listen((event) => add(event));
//     on<OnCityChanged>((event, emit) => _getweatherData(event, emit));
//   }

//   void _getweatherData(OnCityChanged event, Emitter<WeatherState> emit) async {
//     emit(WeatherLoading());
//     final result = await getCurrentWeatherUseCase.execute(event.cityName);
//     //fold method from either is to determine if there is a problem in getting the data or not
//     result.fold((l) => emit(WeatherLoadFailuer(message: l.message)),
//         (r) => emit(WeatherLoaded(result: r)));
//   }

//   @override
//   Future<void> close() {
//     _cityChangedController.close();
//     return super.close();
//   }
// }