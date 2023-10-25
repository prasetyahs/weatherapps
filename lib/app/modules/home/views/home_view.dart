import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_apps/app/data/model/weather_model.dart';
import 'package:weather_apps/app/routes/app_pages.dart';
import 'package:weather_apps/utilities/env.dart';
import 'package:weather_apps/utilities/exports.dart';
import 'package:weather_apps/utilities/weather_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          centerTitle: false,
          automaticallyImplyLeading: false,
        ),
        body: controller.obx(
          (state) => RefreshIndicator(
            onRefresh: (){
              controller.isRefresh.value = true;
              return controller.getLocation();
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                ListWeather listWeather = state![index];
                return GestureDetector(
                    onTap: () => Get.toNamed(Routes.WEATHER_DETAIL,
                        arguments: {"detail": listWeather}),
                    child: WeatherPredictRow(
                      date: controller.formatDateTime(listWeather.dtTxt!),
                      description: listWeather.weather![0].main!,
                      imgName: listWeather.weather![0].icon!,
                      temp:
                          "${controller.kelvinToCelsius(listWeather.main!.temp).toStringAsFixed(1)} °C",
                    ));
              },
              itemCount: 5,
            ),
          ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: const Center(child: Text('No data found')),
          onError: (error) => Center(child: Text(error!)),
        ));
  }
}

class WeatherPredictRow extends GetView {
  const WeatherPredictRow({
    super.key,
    required this.imgName,
    required this.date,
    required this.temp,
    required this.description,
  });
  final String imgName, date, temp, description;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.5, color: WeatherColors.dark()))),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: "${Env.IMAGE_URL + imgName}@2x.png",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(
          date,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              "Temp : $temp",
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
