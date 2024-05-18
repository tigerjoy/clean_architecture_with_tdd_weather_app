import 'dart:io';

import 'package:clean_architecture_with_tdd_weather_app/core/error/exception.dart';
import 'package:clean_architecture_with_tdd_weather_app/core/error/failure.dart';
import 'package:clean_architecture_with_tdd_weather_app/data/models/weather_model.dart';
import 'package:clean_architecture_with_tdd_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03n',
    temperature: 281.97,
    pressure: 1011,
    humidity: 86,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03n',
    temperature: 281.97,
    pressure: 1011,
    humidity: 86,
  );

  const testCityName = "New York";

  group(
    "Get Current Weather",
    () {
      // 1. Returns current weather data on successful API request
      test(
        "Should return current weather when a call to data source is successful",
        () async {
          // Arrange (Stub the data)
          when(
            mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
          ).thenAnswer(
            (_) async => testWeatherModel,
          );

          // Act
          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);

          // Assert
          expect(result, equals(const Right(testWeatherEntity)));
        },
      );

      // 2. Returns ServerFailure when request to API fails
      test(
        "Should return ServerFailure when a call to data source is unsuccessful",
        () async {
          // Arrange (Stub the data)
          when(
            mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
          ).thenThrow(ServerException());

          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);

          // Act & Assert
          expect(result,
              equals(const Left(ServerFailure("An error has occurred."))));
        },
      );

      // 3. Returns ConnectionFailure when app cannot connect to the internet
      test(
        "Should return ConnectionFailure when the device has no internet",
        () async {
          // Arrange (Stub the data)
          when(
            mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
          ).thenThrow(
              const SocketException("Failed to connect to the network"));

          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);

          // Act & Assert
          expect(
              result,
              equals(const Left(
                  ConnectionFailure("Failed to connect to the network."))));
        },
      );
    },
  );
}
