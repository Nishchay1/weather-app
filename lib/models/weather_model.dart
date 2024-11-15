class Weather {
  final String city;
  final double temperature;
  final String mainCondition;
  final String icon;

  Weather({
    required this.city,
    required this.temperature,
    required this.mainCondition,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }
}