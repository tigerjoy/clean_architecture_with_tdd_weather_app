import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_with_tdd_weather_app/core/error/failure.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/entities/weather.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_event.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

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

  test(
    "Initial state should be empty",
    () {
      expect(weatherBloc.state, equals(WeatherEmpty()));
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    "Should emit [WeatherLoading, WeatherLoaded] when data is received",
    // Arrange
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeatherEntity));
      return weatherBloc;
    },
    // Act
    act: (block) => block.add(const OnCityChanged(testCityName)),
    // Since weare using a transformer, we instruct bloc_test to wait
    // 500ms before trying to expect, without the wait, the test would
    // fail
    wait: const Duration(milliseconds: 500),
    // Assert
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeatherEntity),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    "Should emit [WeatherLoading, WeatherLoadFailure] when fetching data is unsuccessful",
    // Arrange
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Left(ServerFailure("Server failure")));
      return weatherBloc;
    },
    // Act
    act: (block) => block.add(const OnCityChanged(testCityName)),
    // Since weare using a transformer, we instruct bloc_test to wait
    // 500ms before trying to expect, without the wait, the test would
    // fail
    wait: const Duration(milliseconds: 500),
    // Assert
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure('Server failure'),
    ],
  );
}
