import 'package:flutter/material.dart';

import 'package:weather_app/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
                fontFamily: 'Lato',
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}
