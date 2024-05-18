import 'package:clean_architecture_with_tdd_weather_app/core/error/failure.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  // Either is a type that is used to denote what kind
  // of value will be returned,
  // In case of successful call, we return the type of value
  // on the right.
  // In case of failure, we return the type of value
  // on the left.
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}