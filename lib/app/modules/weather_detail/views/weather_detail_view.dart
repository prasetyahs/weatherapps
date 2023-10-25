import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_apps/utilities/env.dart';
import 'package:weather_apps/utilities/exports.dart';
import 'package:weather_apps/app/modules/weather_detail/controllers/weather_detail_controller.dart';

class WeatherDetailView extends GetView<WeatherDetailController> {
  const WeatherDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather Details'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            TitleValue(
                fontSizeVal: 18.sp,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                title: controller
                    .formatDateTime(controller.listWeather.dtTxt!)
                    .split("/")[0],
                fontWeightVal: FontWeight.normal,
                val: controller
                    .formatDateTime(controller.listWeather.dtTxt!)
                    .split("/")[1]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${controller.kelvinToCelsius(controller.listWeather.main!.temp).toStringAsFixed(1)} °C",
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
                  ),
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "${Env.IMAGE_URL + controller.listWeather.weather![0].icon!}@4x.png",
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ],
              ),
            ),
            Text(
              "${controller.listWeather.weather![0].main!} (${controller.listWeather.weather![0].description!})",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleValue(
                      fontSizeVal: 16.sp,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      fontWeightVal: FontWeight.w800,
                      title: "Temp (min)",
                      val:
                          "${controller.kelvinToCelsius(controller.listWeather.main!.tempMin).toStringAsFixed(1)} °C"),
                  TitleValue(
                      fontSizeVal: 16.sp,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      fontWeightVal: FontWeight.w800,
                      title: "Temp (max)",
                      val:
                          "${controller.kelvinToCelsius(controller.listWeather.main!.tempMax).toStringAsFixed(1)} °C"),
                ],
              ),
            )
          ],
        ));
  }
}

class TitleValue extends GetWidget {
  final double fontSize, fontSizeVal;
  final FontWeight fontWeight, fontWeightVal;
  final String title, val;

  const TitleValue(
      {super.key,
      required this.fontSizeVal,
      required this.fontSize,
      required this.fontWeight,
      required this.title,
      this.fontWeightVal = FontWeight.normal,
      required this.val});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
        Text(
          val,
          style: TextStyle(fontSize: fontSizeVal, fontWeight: fontWeightVal),
        ),
      ],
    );
  }
}
