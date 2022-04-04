
import 'package:flutter/material.dart';
import 'package:weather_data/weather_model.dart';


class WeatherDetails extends ChangeNotifier {
  final TextEditingController cityController = TextEditingController();
  Weather? weather;
  Main? main;
  String cityName = "karachi";
  String apikey = "2dba79d2ea3efcd5c47300a3c61edfaa"; //static
  bool isLoading = false;

  // searchCity(String name) {
  //   cityName = name;
  //   notifyListeners();
  // }
}
