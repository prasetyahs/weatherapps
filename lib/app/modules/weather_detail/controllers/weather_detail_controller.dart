import 'package:get/get.dart';
import '../../../data/model/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherDetailController extends GetxController {
  //TODO: Implement WeatherDetailController

  final count = 0.obs;
  final ListWeather listWeather = Get.arguments['detail'];
  @override
  void onInit() {
    super.onInit();
  }

  String formatDateTime(String inputDate) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outputFormat = DateFormat("EEE, MMM d, yyyy / h:mm a");
    DateTime date = inputFormat.parse(inputDate);
    String formattedDate = outputFormat.format(date);
    return formattedDate;
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
