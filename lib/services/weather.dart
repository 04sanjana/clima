import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart'; // Ensure this file exists

const apiKey = 'a28551b2756134ceabb77532e6d2ef71';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
  var weatherData= networkHelper.getData();
  return weatherData;
  }
  // Fetch weather data based on the current location
  Future<dynamic> getLocationWeather() async {
    // Ensure that Location class is properly defined in location.dart
    Location location = Location();
    await location.getCurrentLocation();

    // Build the URL with the correct lat, lon, apiKey, and units=metric
    String url =
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

    // Fetch weather data using NetworkHelper
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // Returns a weather icon based on the weather condition
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  // Returns a weather message based on the temperature in Celsius
  String getMessage(double tempInCelsius) {
    if (tempInCelsius > 25) {
      return 'It\'s 🍦 time';
    } else if (tempInCelsius > 20) {
      return 'Time for shorts and 👕';
    } else if (tempInCelsius < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
