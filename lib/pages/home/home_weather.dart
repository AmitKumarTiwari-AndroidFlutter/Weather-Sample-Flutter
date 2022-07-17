
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_sample/pages/home/home_weather_controller.dart';
import 'package:weather_sample/pages/forecast/forecast_page.dart';
import 'package:weather_sample/utils/app_color.dart';
import '../../models/location_res.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomeWeather extends GetView<HomeWeatherController> {

  @override
  HomeWeatherController controller = Get.put(HomeWeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.checkWeatherData(controller.locationPick.value);
        },
       child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: GestureDetector(
                  onTap: (){
                    Get.to( PlacePicker(
                      apiKey: Platform.isAndroid
                          ? "AIzaSyD-884kxynfx6veYZQwydwHIpGdT6M5HnA"
                          : "AIzaSyD-884kxynfx6veYZQwydwHIpGdT6M5HnA",
                      onPlacePicked: (PickResult result) {
                        controller.selectedPlace.value = result;
                        controller.locationPick.value =  LocationRes(
                            city: controller.selectedPlace.value.addressComponents![0].shortName.toString(),
                            lat: controller.selectedPlace.value.geometry?.location.lat,
                            lon: controller.selectedPlace.value.geometry?.location.lng);

                        controller.checkWeatherData(controller.locationPick.value);

                        print(controller.selectedPlace.value.formattedAddress.toString());
                        print(controller.selectedPlace.value.geometry?.location.lat);
                        print(controller.selectedPlace.value.geometry?.location.lng);

                        Get.back();

                      },
                      initialPosition: const LatLng(-33.8567844, 151.213108),
                      useCurrentLocation: true,
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() =>
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                                controller.locationPick.value.city,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
                            ),
                          ),
                      ),
                      const SizedBox(width: 20,),
                      const Icon(Icons.search)
                    ],
                  )


                ),
              ),
              AspectRatio(
                aspectRatio: 0.88,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 8.0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: AppColor.tealColor,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(()=>
                                  Image.asset(
                                  controller.current.value.icon.isNull ? 'assets/01d.png' :
                                    controller.getIconUrl(controller.current.value.icon.toString()),
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Obx(() =>
                                  Text(
                                      controller.current.value.description.isNull ? '' :
                                    controller.current.value.description.toString(),
                                    style: const TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Obx(() =>
                                  Text(
                                    controller.getDate(controller.current.value.dt).toString(),
                                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                                  ),
                                ),

                                // Text(
                                //   controller.getDate(controller.current.value.dt!),
                                //   style: const TextStyle(color: Colors.white, fontSize: 16.0),
                                // ),
                                Expanded(
                                  child: Center(
                                    child: Obx(() => Text(
                                        controller.current.value.temp.isNull ? '' :
                                        '${controller.current.value.temp?.toInt()}°',
                                        style: const TextStyle(
                                            fontSize: 64.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: DecoratedBox(
                            decoration: const BoxDecoration(color: Colors.white),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                          margin: const EdgeInsets.only(
                                            top: 1.0,
                                            left: 0.5,
                                            right: 0.5,
                                          ),
                                          color: AppColor.tealColor,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'assets/wind_icon.png',
                                                width: 32,
                                                height: 32,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Wind',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white70,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                  Obx(() => Text(
                                                    controller.current.value.wind.isNull ? '' :
                                                      '${controller.current.value.wind}km/h',
                                                      style: const TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                          margin: const EdgeInsets.only(
                                            top: 1.0,
                                            left: 0.5,
                                            right: 0.5,
                                          ),
                                          color: AppColor.tealColor,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'assets/temperature_icon.png',
                                                width: 32,
                                                height: 32,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Feels like',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white70,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                  Obx(() => Text(
                                                      controller.current.value.feelsLike.isNull ? '' :
                                                      '${controller.current.value.feelsLike?.toInt()}°',
                                                      style: const TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                          margin: const EdgeInsets.only(
                                            top: 1.0,
                                            left: 0.5,
                                            right: 0.5,
                                          ),
                                          color: AppColor.tealColor,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'assets/uvi_icon.png',
                                                width: 32,
                                                height: 32,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Index UV',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white70,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                  Obx(() => Text(
                                                    controller.current.value.uvi.isNull ? '' :
                                                      '${controller.current.value.uvi}',
                                                      style: const TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                          margin: const EdgeInsets.only(
                                            top: 1.0,
                                            left: 0.5,
                                            right: 0.5,
                                          ),
                                          color: AppColor.tealColor,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'assets/pressure_icon.png',
                                                width: 32,
                                                height: 32,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Pressure',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white70,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                  Obx(() => Text(
                                                    controller.current.value.pressure.isNull ? '' :
                                                      '${controller.current.value.pressure}hPa',
                                                      style: const TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.to(ForecastPage(), arguments: controller.weatherDailyForecast.value);
                            },
                            child: Row(
                              children: const [
                                Text(
                                  'Next 7 days',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.w600),
                                ),
                                Icon(CupertinoIcons.right_chevron,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 130.0,
                      child: Obx(() => ListView.separated(
                            itemCount: controller.weatherHourlyForecast.value.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 8.0,
                              );
                            },
                            itemBuilder: (context, index) {
                              final forecast = controller.weatherHourlyForecast.value[index];
                              return AspectRatio(
                                aspectRatio: 0.54,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: AppColor.lightTealColor,
                                      border: Border.all(color: AppColor.midTealColor, width: 5.2),
                                      borderRadius: BorderRadius.circular(12.0)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(controller.getTime(forecast.dt).toString()),
                                        Image.asset(
                                          controller.getIconUrl(forecast.icon.toString()),
                                          width: 42.0,
                                          height: 42.0,
                                          fit: BoxFit.fill,
                                        ),
                                        Text(
                                          '${forecast.temp}°',
                                          style: const TextStyle(fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}