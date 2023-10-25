import 'package:get/get.dart';
import 'package:weather_apps/app/data/repository/weather_repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(WeatherRepository()),
    );
  }
}
