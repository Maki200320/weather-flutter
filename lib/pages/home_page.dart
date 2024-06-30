import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/widgets/app_bar.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService weatherService = WeatherService();
  String city = 'Philippines';
  Map<String, dynamic>? weatherData;

  Future<void> fetchWeather() async {
    try {
      final data = await weatherService.fetchWeather(city);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void _onTextChanged(String newText) {
    setState(() {
      city = newText;
    });
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(33, 68, 114, 1),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(onTextChanged: _onTextChanged),
        ),
        body: weatherData == null
            ? Column(
                children: [
                  SizedBox(
                    height: 500.0,
                    width: 1000.0,
                    child: Lottie.asset('assets/Loading.json'),
                  ),
                  const Text("Something Went Wrong..."),
                  const Text("Check Your Internet Connection...")
                ],
              )
            : SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            '🗺️ ${weatherData?['location']['name']}, ${weatherData?['location']['country']} ',
                            style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: SizedBox(
                            height: 250.0,
                            child: Lottie.asset(
                                weatherService.getWeatherAnimation(
                                  weatherData?['current']['condition']
                                          ['text'] ??
                                      '',
                                ),
                                width: 250.0,
                                height: 250.0),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 40.0,
                                height: 100.0,
                                child: Lottie.asset('assets/Temperature.json')),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '${weatherData?['current']['temp_c']}°C',
                              style: const TextStyle(
                                  fontSize: 45.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 40.0,
                            ),
                          ],
                        ),
                        Text('${weatherData?['current']['condition']['text']}',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
