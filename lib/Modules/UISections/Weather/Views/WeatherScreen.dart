import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Manager/WeatherManager.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/TemperatureInfoView.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/WeatherGridList.dart';

import '../../../../Config/WeatherConfig.dart';
import '../../../Service/LocationService/LocationService.dart';
import '../../../Service/NetworkService/NetworkService.dart';
import '../Model/WeatherResult.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherResult? weatherResult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startServerCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0XFF2E335A),
        flexibleSpace: Container(
          decoration: getGradientBG(),
        ),
      ),
      body: Builder(builder: (context) {
        return Container(
          decoration: getGradientBG(),
          child: Column(
            children: [
              makeTopView(),
              Expanded(
                child: WeatherGridList(
                  weatherResult: weatherResult,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> startServerCall() async {
    print('start server');
    try {
      print('Checking location permission...');
      final locationData = await LocationService.shared.getCurrentLocation();
      final lat = locationData.latitude;
      final lon = locationData.longitude;
      print('lat  = $lat, lon = $lon');
      final url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${WeatherConfig.apiKey}";
      final data = await NetworkService.shared
          .genericApiRequest(url, RequestMethod.get, WeatherResult.fromJson);
      setState(() {
        weatherResult = data;
        print('sunset = ${weatherResult?.sys?.sunset}');
      });
        } catch (err) {
      print('err = ${err.toString()}');
    }
  }

  Widget makeTopView() {
    return Container(
      height: 94.0,
      width: double.infinity,
      decoration: getGradientBG(),
      child: TemperatureInfoView(
          place: weatherResult?.name ?? "Not Found",
          temperature:
              '${WeatherManager.shared.kelvinToCelsius(weatherResult?.main?.temperature ?? 0.0).toStringAsFixed(2)}\u00b0',
          description: weatherResult?.weather?.first.description ?? ""),
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
