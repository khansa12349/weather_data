import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_data/weather_details.dart';
import 'package:weather_data/weather_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherDetails(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'weather app',
        theme: ThemeData(primaryColor: Colors.blue),
        home:  const WeatherScreen(),
      ),
    );
  }
}
