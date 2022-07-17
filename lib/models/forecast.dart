import 'package:intl/intl.dart';

class Forecast {
   int? dt;
   double? temp;
   double? wind;
   double? feelsLike;
   double? pressure;
   double? uvi;
   String? description;
   String? icon;

  Forecast({
    this.dt,
    this.temp,
    this.wind,
    this.feelsLike,
    this.pressure,
    this.uvi,
    this.description,
    this.icon,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
        dt: json['dt'].toInt(),
        temp: json['temp'].toDouble(),
        wind: json['wind_speed'].toDouble(),
        feelsLike: json['feels_like'].toDouble(),
        pressure: json['pressure'].toDouble(),
        uvi: json['uvi'].toDouble(),
        description: json['weather'][0]['description'],
        icon: json['weather'][0]['icon']);
  }
}


