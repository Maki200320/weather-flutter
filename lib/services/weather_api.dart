import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '69777a0d94ad4f559cf31458242506';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load weather data');
    }
  }

  String getWeatherAnimation(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return 'assets/Sunny.json';
      case 'cloudy':
      case 'overcast':
      case 'partly cloudy':
        return 'assets/Cloudy.json';
      case 'moderate rain':
      case 'patchy rain nearby':
      case 'rain':
      case 'rainy':
      case 'heavy rain':
      case 'light rain':
        return 'assets/Rainy.json';

      default:
        return 'assets/Sunny.json'; // default animation if condition is not matched
    }
  }
}
