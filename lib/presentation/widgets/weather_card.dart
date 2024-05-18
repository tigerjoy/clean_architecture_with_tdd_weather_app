import 'package:clean_architecture_with_tdd_weather_app/core/constants/constants.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_state.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final WeatherLoaded state;

  const WeatherCard({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key("weather_data"),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.result.cityName,
              style: const TextStyle(
                fontSize: 22.0,
              ),
            ),
            Image(
              image: NetworkImage(
                Urls.weatherIcon(
                  state.result.iconCode,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "${state.result.main} | ${state.result.description}",
          style: const TextStyle(
            fontSize: 16.0,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 24.0),
        Table(
          defaultColumnWidth: const FixedColumnWidth(150.0),
          border: TableBorder.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1),
          children: [
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Temperature",
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.result.temperature.toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Pressure",
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.result.pressure.toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Humidty",
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.result.humidity.toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
