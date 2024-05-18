import 'dart:convert';

import 'package:clean_architecture_with_tdd_weather_app/data/models/weather_model.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  // 1. Is the model that we have created equal to
  //    the entity in the Domain layer?
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03n',
    temperature: 281.97,
    pressure: 1011,
    humidity: 86,
  );

  test(
    "Should be a subclass of weather entity",
    () async {
      // Assert
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );

  // 2. Does the fromJson() function return a valid
  //    JSON for a valid model?

  test(
    "Should return a valid model from JSON",
    () async {
      // Arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

      // Act
      final result = WeatherModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(testWeatherModel));
    },
  );

  // 3. Does the toJson() function return the appropriate
  //    JSON map?
  test(
    "Should return a JSON map containing proper data",
    () async {
      // Act
      final result = testWeatherModel.toJson();

      // Assert
      final expectedJsonMap = {
        "weather": [
          {
            "main": 'Clouds',
            "description": 'scattered clouds',
            "icon": '03n',
          }
        ],
        "main": {
          "temperature": 281.97,
          "pressure": 1011,
          "humidity": 86,
        },
        "name": 'New York'
      };

      expect(result, equals(expectedJsonMap));
    },
  );
}
