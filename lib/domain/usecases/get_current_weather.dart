import 'package:clean_architecture_with_tdd_weather_app/core/error/failure.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/entities/weather.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}