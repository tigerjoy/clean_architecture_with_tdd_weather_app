import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_event.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/bloc/weather_state.dart';
import 'package:clean_architecture_with_tdd_weather_app/presentation/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1E22),
        title: const Text(
          "WEATHER",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Enter city name",
                fillColor: const Color(0xFFF3F3F3),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                context.read<WeatherBloc>().add(OnCityChanged(value));
              },
            ),
            const SizedBox(
              height: 32.0,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeatherLoaded) {
                  return WeatherCard(
                    state: state,
                  );
                } else if (state is WeatherLoadFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
