import 'package:equatable/equatable.dart';

// This Event will be called when the user
// enters the cityName
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class OnCityChanged extends WeatherEvent {
  final String cityName;

  const OnCityChanged(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
