import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:flutter/services.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  final _weatherService = WeatherService("");
  Weather ? _weather;

  _fetchWeather() async {
    List coordinates = await _weatherService.getCurrentCoordinates();

    try {
      final weather = await _weatherService.getWeather(coordinates);
      setState(() {
        _weather = weather;
      });
    }

    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherIcon(String ? mainCondition){
    if (mainCondition == null){
      return 'assets/sunny.png';
    }
    switch (mainCondition.toLowerCase()){
      case 'clouds':
        return 'assets/clouds.png';
      case 'mist':
        return 'assets/mist.png';
      case 'smoke':
        return 'assets/mist.png';
      case 'haze':
        return 'assets/mist.png';
      case 'dust':
        return 'assets/mist.png';
      case 'fog':
        return 'assets/mist.png';
      case 'rain':
        return 'assets/rain.png';
      case 'drizzle':
        return 'assets/rain.png';
      case 'shower rain':
        return 'assets/rain.png';
      case 'thunderstorm':
        return 'assets/thunderstorm.png';
      case 'clear':
        return 'assets/sunny.png';
      default:
        return 'assets/sunny.png';
    }
  }

  @override
  Widget build(BuildContext context) {

    //force portrait mode
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(_weather?.city ?? "Loading city...",
            style: const TextStyle(fontSize: 40,fontFamily: 'Gaegu'),
          ),

          Image(image: AssetImage(getWeatherIcon(_weather?.mainCondition))),
        
          //Image(image: NetworkImage("https://openweathermap.org/img/wn/${_weather?.icon ?? "01d"}.png")),

          Text("${_weather?.temperature.round()}°F",
            style: const TextStyle(fontSize: 40,fontFamily: 'Gaegu'),
          ),

          Text(_weather?.mainCondition ?? "",
            style: const TextStyle(fontSize: 40,fontFamily: 'Gaegu'),
          )
        ],),
      )
      // body: Padding(
      //   padding: const EdgeInsets.fromLTRB(40,20, 40, 20),
      //   child: SizedBox(
      //     height: MediaQuery.of(context).size.height,
          
      //   ),
      // )
    );
  }
}