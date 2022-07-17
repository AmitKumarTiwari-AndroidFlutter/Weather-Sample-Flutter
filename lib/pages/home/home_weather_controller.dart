import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../constants/api_constants.dart';
import '../../models/daily_forecaset.dart';
import '../../models/forecast.dart';
import '../../models/location_res.dart';
import '../../models/weather.dart';
import '../../utils/base_mixin.dart';

class HomeWeatherController extends GetxController with BaseMixin {
  var locationPick = LocationRes(city: 'Noida', lat: 28.5355, lon: 77.3910).obs;
  late Weather weatherResp;

  // late Forecast current;
  var weatherHourlyForecast = <Forecast>[].obs;
  var weatherDailyForecast = <DailyForecast>[].obs;
  var selectedPlace = PickResult().obs;
  var current = Forecast().obs;

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
    checkWeatherData(locationPick.value);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkWeatherData(LocationRes locRes) async {
    showProgress();
    await http
        .get(Uri.parse(
            '$BASE_API_ENDPOINT?lat=${locRes.lat}&lon=${locRes.lon}&exclude=minutely,alerts&appid=$APP_ID&units=metric'))
        .then((resp) async {
      hideProgress();
      if (resp.statusCode == 200) {
        var respData = Weather.fromJson(json.decode(resp.body));
        weatherResp = respData;
        current.value = weatherResp.current;
        weatherHourlyForecast.value = weatherResp.hourly;
        weatherDailyForecast.value = weatherResp.daily;
      }
      if (resp.statusCode == 422) {
        showErrorMessage(message: "Something went wrong.");
        // hideProgress();
      }
    }, onError: (err) {
      showErrorMessage(message: "Server error.");
      hideProgress();
    });
  }

  String? getDate(int? dt) {
    if (dt != null) {
      var myDate = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
      var date = DateFormat('EEEE, dd MMM').format(myDate);
      return date;
    } else {
      return '';
    }
  }

  String? getTime(int? dt) {
    if (dt != null) {
      var myDate = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
      var time = DateFormat('HH:mm').format(myDate);
      return time;
    } else {
      return '';
    }
  }

  String getIconUrl(String icon) {
    return 'assets/$icon.png';
  }
}
