import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_apps/app/data/model/weather_model.dart';
import 'package:weather_apps/app/data/repository/weather_repository.dart';
import 'package:weather_apps/service/location_service.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController with StateMixin<List<ListWeather>> {
  final LocationService _locationService = LocationService();
  final WeatherRepository weatherRepository;
  final listWeather = [].obs;
  var isRefresh = false.obs;
  HomeController(this.weatherRepository);
  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  getLocation() async {
    if (isRefresh.value) {
      change([],status: RxStatus.loading());
    }
    bool hasPermission = await _locationService.checkLocationPermission();
    if (hasPermission) {
      Position? currentPosition = await _locationService.getCurrentLocation();
      if (currentPosition != null) {
        await getWeather(currentPosition.latitude.toString(),
            currentPosition.longitude.toString());
      }
    } else {
      await Geolocator.openLocationSettings();
    }
    isRefresh.value = false;
  }

  getWeather(lat, lon) async {
    await weatherRepository.getWeatherPredict(lat, lon).then((value) {
      WeatherModel weatherModel = WeatherModel.fromJson(jsonDecode(value.body));
      List<ListWeather>? listWeather = weatherModel.listWeather;
      change(listWeather, status: RxStatus.success());
    });
  }

  String formatDateTime(String inputDate) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outputFormat = DateFormat("EEE, MMM d, yyyy h:mm a");
    DateTime date = inputFormat.parse(inputDate);
    String formattedDate = outputFormat.format(date);
    return formattedDate;
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }
}
