import 'package:clean_architecture_with_tdd_weather_app/injection_container.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Setup All the class initializations
  // Dependency Injection
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // We use Bloc dependency injection such that a single
    // instance of the block can be provided to multiple
    // widgets in a sub-tree
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<WeatherBloc>(),
        ),
      ],
      child: const MaterialApp(
        home: WeatherPage(),
      ),
    );
  }
}
