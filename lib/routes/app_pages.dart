
import 'package:get/get.dart';
import 'package:weather_sample/pages/forecast/forecast_page.dart';
import 'package:weather_sample/pages/home/home_weather.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeWeather(),
    ),
    GetPage(
      name: _Paths.FORECAST,
      page: () => ForecastPage(),
    ),
  ];
}
