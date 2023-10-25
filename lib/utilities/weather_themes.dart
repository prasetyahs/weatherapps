import 'package:google_fonts/google_fonts.dart';
import 'package:weather_apps/utilities/weather_colors.dart';
import 'exports.dart';

class WeatherThemes{
  static ThemeData themeData() => ThemeData(
      primaryColor: WeatherColors.primary(),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme:
          AppBarTheme(color: WeatherColors.primary(), centerTitle: false),
      textTheme: TextTheme(
          displayMedium:
              GoogleFonts.inter(textStyle: TextStyle(fontSize: 15.sp)), //h1
          displaySmall:
              GoogleFonts.inter(textStyle: TextStyle(fontSize: 13.sp)), //h2
          headlineMedium:
              GoogleFonts.inter(textStyle: TextStyle(fontSize: 11.sp)), //h3
          titleSmall: GoogleFonts.inter(
              textStyle: TextStyle(fontSize: 11.sp)), //subtitle 1
          bodyLarge: GoogleFonts.inter(
              textStyle: TextStyle(fontSize: 10.sp)), //subtitle2
          labelSmall:
              GoogleFonts.inter(textStyle: TextStyle(fontSize: 12.sp)) //button
          ));
}