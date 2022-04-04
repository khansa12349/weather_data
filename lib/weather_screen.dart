import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_data/weather_details.dart';
import 'package:weather_data/weather_model.dart';
import 'http-service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherData? weatherData;

  var temp = 273.15;

  //final double temp = WeatherData.main!.temp! - 273.15;

  static String _apikey = "2dba79d2ea3efcd5c47300a3c61edfaa";
  HttpService http = HttpService();

  Future<WeatherData?> getWeatherData(String cityName) async {
    try {
      final response = await http.getRequest(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apikey');

      print(response.data);
      if (response.statusCode == 200) {
        WeatherData weatherResult = WeatherData.fromJson(response.data);

        return weatherResult;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<WeatherDetails>((context), listen: true);
    print(weatherData?.main?.temp);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Weather App                                        ☼",
            style: TextStyle(
              backgroundColor: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
          decoration: const BoxDecoration(
            color: Colors.grey,

            image: DecorationImage(
                image: AssetImage("assets/sun.png"), fit: BoxFit.cover),
                ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: TextField(
                  controller: state.cityController,
                  decoration: const InputDecoration(
                    labelText: 'enter city to search weather',
                    icon: Icon(Icons.location_city),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                  child: const Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        backgroundColor: Colors.black),
                  ),
                  onPressed: () async {
                    final data =
                        await getWeatherData(state.cityController.text);
                    setState(() {
                      weatherData = data;
                    });
                  }),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Wind",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      weatherData != null
                          ? "${weatherData?.wind?.speed}km/hr"
                          : " ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Humidity",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      weatherData != null
                          ? "${weatherData?.main?.humidity}%"
                          : " ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Temperature",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    weatherData != null
                        ? Text(
                            "${weatherData?.main!.temp!}°C",
                                // "-${temp.toDouble()}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : const Text(
                            " ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        )
        )
    );
  }
}
