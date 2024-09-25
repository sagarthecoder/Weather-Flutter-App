class WeatherManager {
  WeatherManager._internal();
  static final shared = WeatherManager._internal();

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  double kelvinToFahrenheit(double kelvin) {
    return (9.0 / 5.0) * (kelvin - 273.15) + 32;
  }
}
