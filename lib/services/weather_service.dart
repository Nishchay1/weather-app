import 'dart:convert';

import 'package:location/location.dart';

import 'package:weather_app/models/weather_model.dart';

import 'package:http/http.dart' as http;

Location location = Location();

class WeatherService {
  static const baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(List coordinates) async {
    final response = await http.get(Uri.parse('$baseURL?lat=${coordinates[0]}&lon=${coordinates[1]}&appid=$apiKey&units=imperial'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } 
    else {
      throw Exception('Failed to load weather data. ${response.statusCode}');
    }
  }

  Future<List> getCurrentCoordinates() async {
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied){
      permission = await location.requestPermission();
    }
    LocationData locationData = await location.getLocation();
    return [locationData.latitude, locationData.longitude];
  }
}