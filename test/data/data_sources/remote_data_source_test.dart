import 'package:clean_architecture_with_tdd_weather_app/core/constants/constants.dart';
import 'package:clean_architecture_with_tdd_weather_app/core/error/exception.dart';
import 'package:clean_architecture_with_tdd_weather_app/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_with_tdd_weather_app/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = "New York";

  // Group multiple tests that are related to each other
  group("Get Current Weather", () {
    test(
      "Should Return WeatherModel when the response code is 200",
      () async {
        // Stub the data --> Return fake data
        // Arrange
        when(
          mockHttpClient.get(
            Uri.parse(
              Urls.currentWeatherByName(testCityName),
            ),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson("helpers/dummy_data/dummy_weather_response.json"),
            200,
          ),
        );

        // Act
        final result =
            await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

        // Assert
        expect(result, isA<WeatherModel>());
      },
    );

    test(
      "Should throw a ServerException when the response code is not 200",
      () async {
        // Stub the data --> Return fake data
        // Arrange
        when(
          mockHttpClient.get(
            Uri.parse(
              Urls.currentWeatherByName(testCityName),
            ),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            "Not found",
            404,
          ),
        );

        // Act & Assert
        expect(() async {
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
        }, throwsA(isA<ServerException>()));
      },
    );
  });
}
