import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/entities/weather.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_event.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_state.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    // By deafult, the mock HttpClient returns 404 status code
    // This line below would get actual http responses from the Server
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  // 1. The state of the app should change from WeatherEmpty
  //    to WeatherLoading when filling text fields is finished
  testWidgets(
    "Text field should trigger state to change from empty to loading",
    (widgetTester) async {
      // Arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      // Act
      // 1. Initialize the widget to be tested
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
      // 2. See if the TextField is present in the widget or not
      var textField = find.byType(TextField);

      // Assert
      expect(textField, findsOneWidget);

      // Act
      await widgetTester.enterText(textField, "New York");
      // Renders a new frame
      await widgetTester.pump();

      // Assert
      expect(find.text("New York"), findsOneWidget);
    },
  );

  // 2. Displays a progress indicator when the state of the
  //    application is WeatherLoading
  testWidgets(
    "Should show progress indicator when state is loading",
    (widgetTester) async {
      // Arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      // Act
      // 1. Initialize the widget to be tested
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      // Assert
      // 2. See if the CircularProgressIndicator is present in the widget or not
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
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

  // 3. Displays a Widget containing Weather information when
  //    the state of the application is WeatherLoaded
  testWidgets(
    "Should show widget contain weather data when state is WeatherLoaded",
    (widgetTester) async {
      // Arrange
      when(() => mockWeatherBloc.state)
          .thenReturn(const WeatherLoaded(testWeatherEntity));

      // Act
      // 1. Initialize the widget to be tested
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
      // Renders a new frame
      await widgetTester.pumpAndSettle();

      // Assert
      // 2. See if the WeatherCard widget is present in the WeatherPage or not
      // expect(find.byType(WeatherCard), findsOneWidget);
      expect(find.byKey(const Key("weather_data")), findsOneWidget);
    },
  );
}
