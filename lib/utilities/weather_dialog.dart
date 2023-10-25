import 'package:weather_apps/utilities/weather_colors.dart';

import 'exports.dart';

class WeatherDialog{

  static showDialogMessage({message, status}) =>
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: status ? WeatherColors.good() : Colors.red,
      ));
}