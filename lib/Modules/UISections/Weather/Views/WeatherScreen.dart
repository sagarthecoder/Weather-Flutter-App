import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/Modules/UISections/Weather/ViewModel/WeatherViewModel.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/TemperatureInfoView.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/WeatherGridList.dart';

import '../Manager/WeatherManager.dart';
import '../Model/WeatherResult.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    // Call updateCurrentWeather after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().updateCurrentWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF2E335A),
        flexibleSpace: Container(
          decoration: getGradientBG(),
        ),
      ),
      body: Consumer<WeatherViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            decoration: getGradientBG(),
            child: Column(
              children: [
                makeTopView(context),
                Expanded(
                  child: WeatherGridList(
                    weatherResult: viewModel.weatherResult,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget makeTopView(BuildContext context) {
    WeatherViewModel viewModel = context.read<WeatherViewModel>();
    WeatherResult? weatherResult = viewModel.weatherResult;
    return Container(
      height: 94.0,
      width: double.infinity,
      decoration: getGradientBG(),
      child: TemperatureInfoView(
        place: weatherResult?.name ?? "Not Found",
        temperature:
            '${WeatherManager.shared.kelvinToCelsius(weatherResult?.main?.temperature ?? 0.0).toStringAsFixed(2)}\u00b0',
        description: weatherResult?.weather?.first.description ?? "",
      ),
    );
  }

  Decoration getGradientBG() {
    return const BoxDecoration(
      color: Color(0XFF2E335A),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Color(0XFF2E335A), Color(0XFF1C1B33)],
      ),
    );
  }
}
