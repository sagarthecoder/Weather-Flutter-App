import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/Modules/UISections/Weather/ViewModel/WeatherViewModel.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/TemperatureInfoView.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/WeatherGridList.dart';

import '../Manager/WeatherManager.dart';
import '../Model/WeatherResult.dart';
import 'CustomSearchDelegate.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherViewModel viewModel = WeatherViewModel();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<WeatherViewModel>(
        context); //context.read<WeatherViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF2E335A),
        flexibleSpace: Container(
          decoration: getGradientBG(),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(parentContext: context),
                );
                if (result != null) {
                  didSelectSearchItem(result.toString());
                }
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: Consumer<WeatherViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              Container(
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
              ),
              showLoaderIfNeeded(),
            ],
          );
        },
      ),
    );
  }

  void didSelectSearchItem(String item) {
    viewModel.updateWeatherByCity(item);
  }

  Widget makeTopView(BuildContext context) {
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

  Widget showLoaderIfNeeded() {
    if (viewModel.isLoading) {
      return Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
