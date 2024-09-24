import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Manager/DateManager.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherEnums.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherResult.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/SunInfoView.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/WeatherInfoView.dart';

class WeatherGridList extends StatefulWidget {
  final WeatherResult? weatherResult;
  const WeatherGridList({required this.weatherResult, super.key});

  @override
  State<WeatherGridList> createState() => _WeatherGridListState();
}

class _WeatherGridListState extends State<WeatherGridList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.0),
      itemCount: WeatherInfoCategory.values.length,
      itemBuilder: (context, index) {
        return _buildGridItem(WeatherInfoCategory.values[index]);
      },
    );
  }

  Widget _buildGridItem(WeatherInfoCategory category) {
    double itemWidth = 150.0; // Set your desired width
    double itemHeight = 150.0; // Set your desired height

    return Container(
      width: itemWidth,
      height: itemHeight,
      decoration: BoxDecoration(
        color: Color(0XFF48319D).withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: getItemView(category),
    );
  }

  Widget getItemView(WeatherInfoCategory category) {
    switch (category) {
      case WeatherInfoCategory.sunInfo:
        DateTime sunrise = DateManager.shared.unixTimestampToLocalDateTime(
            widget.weatherResult?.sys?.sunrise ?? 0);
        DateTime sunset = DateManager.shared.unixTimestampToLocalDateTime(
            widget.weatherResult?.sys?.sunset ?? 0);
        String formattedSunrise =
            DateManager.shared.getTimeInfoFromDateTime(sunrise);
        String formattedSunset =
            DateManager.shared.getTimeInfoFromDateTime(sunset);
        return SunInfoView(
            sunriseTime: formattedSunrise, sunsetTime: formattedSunset);
      case WeatherInfoCategory.wind:
        return WeatherInfoView(
            topText: 'WIND',
            information: '${widget.weatherResult?.wind?.speed ?? 0.00} km/h',
            bottomText: '');
      case WeatherInfoCategory.humidity:
        return WeatherInfoView(
            topText: 'HUMIDITY',
            information: '${widget.weatherResult?.main?.humidity ?? 0}%',
            bottomText: 'The dew point is 17 right now');
      case WeatherInfoCategory.feelsLike:
        return WeatherInfoView(
            topText: 'FEELS LIKE',
            information:
                "${widget.weatherResult?.main?.feelsLike ?? 0.00}'\u00B0'",
            bottomText: '');
    }
  }
}
