import '../utilities/exports.dart';

class WeatherButton {
  static normalButton(onPressed, title, color) => Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: Get.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 10.h)),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
                fontSize:
                    Theme.of(Get.context!).textTheme.displayMedium!.fontSize),
          )));
  static iconButton(onPressed, icon, color) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: onPressed,
          icon: icon));
}
