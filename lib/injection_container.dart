import 'package:clean_architecture_with_tdd_weather_app/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_with_tdd_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/repositories/weather_repository.dart';
import 'package:clean_architecture_with_tdd_weather_app/domain/usecases/get_current_weather.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Makes it easy to retrieve dependencies
// and decouples part of our code
// Global instance of locator
// Provides a centralized location for managing
// service locators and dependency injection
final locator = GetIt.instance;

// 1. This method will be called immediately
//    when the app starts from main
// 2. This method will be reponsible for registering singleton
//    instance of classes and contracts
// 3. And these instances will also be injected using singleton
//    instance of GetIt
// 4. Since we are not holding states in any of the classes
//    therefore, all of them will be configured as singleton
//    instances of classes
// 5. Only one instance of the app will be created per lifetime of the app
// 6. There will be only one exception to the above rule, the WeatherBloc
//    which will be registered first
void setupLocator() {
  // BLOC
  locator.registerFactory(() => WeatherBloc(locator()));

  // Usecase
  // Lazy Registration --> The object will be instantiated
  // when the dependency is requested from some other class

  // Normal Registration --> The object will be instantiated
  // as soon as the call to the setupLocator() method is made
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // Repository
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()));

  // Data Source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: locator()));

  // External
  locator.registerLazySingleton(() => http.Client());
}
