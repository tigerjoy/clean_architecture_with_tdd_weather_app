import 'package:clean_architecture_with_tdd_weather_app/domain/usecases/get_current_weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_event.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>((event, emit) async {
      // Emit the WeatherLoading() state, until API request is successful
      emit(WeatherLoading());

      // Get the weather data from API
      final result = await _getCurrentWeatherUseCase.execute(event.cityName);

      // On failure, emit WeatherLoadFailure event with the failure message
      // On successful data, emit WeatherLoaded event with the weather details
      result.fold(
        (failure) {
          emit(WeatherLoadFailure(failure.message));
        },
        (data) {
          emit(WeatherLoaded(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
