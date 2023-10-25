import 'package:http/http.dart' as http;

import '../api_provider.dart';

class WeatherRepository {
  Future<http.Response> getWeatherPredict(lat,lon) async {
    return ApiProvider.get("lat=$lat&lon=$lon");
  }
}
