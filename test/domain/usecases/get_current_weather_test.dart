import 'package:clean_architecture_with_tdd_weather_app/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/usecases/get_current_weather.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  // Sample WeatherEntity
  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test(
    "Should get current weather detail from repository",
    () async {
      // Arrange
      when(
        mockWeatherRepository.getCurrentWeather(testCityName)
      ).thenAnswer((_) async => const Right(testWeatherDetail));

      // Act
      final result = await getCurrentWeatherUseCase.execute(testCityName);

      // Assert
      expect(result, const Right(testWeatherDetail));
    },
  );
}
