import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_weather_controller.dart';
import '../../models/daily_forecaset.dart';
import '../../utils/app_color.dart';

part 'forecast_list_widget.dart';

class ForecastPage extends GetView<HomeWeatherController> {

  @override
  HomeWeatherController controller = Get.put(HomeWeatherController());

  @override
  Widget build(BuildContext context) {
    final List<DailyForecast> daily = Get.arguments;
    return Scaffold(
      backgroundColor: AppColor.lightTealColor,
      appBar: AppBar(
        backgroundColor: AppColor.tealColor,
        elevation: 0.0,
        centerTitle: true,
        title:Obx(() =>
            Text.rich(TextSpan(
                text: controller.locationPick.value.city,
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold))),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Next 7 Days',
              style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600),
            ),
            ForecastListWidget(
              daily: daily,
            )
          ],
        ),
      ),
    );
  }

}
