import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_apps/app/routes/app_pages.dart';
import 'package:weather_apps/component/weather_button.dart';
import 'package:weather_apps/component/weather_textfield.dart';
import 'package:weather_apps/utilities/exports.dart';
import 'package:weather_apps/utilities/weather_colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/logo.svg",
            width: 100.w,
          ),
          Text(
            "Weather Apps",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30.h,
          ),
          WeatherTextField(
            "Email",
            textEditingController: controller.emailController,
          ),
          SizedBox(
            height: 10.h,
          ),
          WeatherTextField(
            "Password",
            textEditingController: controller.passwordController,
            obsecureText: false,
            suffixIcon: GestureDetector(
                onTap: () {
                  print("tapping");
                },
                child: Icon(Icons.visibility_off)),
          ),
          SizedBox(
            height: 10.h,
          ),
          Obx(
            () => controller.isSignin.value
                ? const CircularProgressIndicator()
                : WeatherButton.normalButton(
                    () => controller.auth("emailAndPassword",
                        password: controller.passwordController.text,
                        email: controller.emailController.text),
                    "Sign In",
                    WeatherColors.primary()),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Or sign in with",
            style: TextStyle(
                fontSize: 13.sp,
                color: WeatherColors.dark(),
                letterSpacing: 0.5),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherButton.iconButton(
                  () => controller.showPhoneVerificationInput(),
                  const Icon(
                    Icons.phone_android,
                    color: Colors.white,
                  ),
                  WeatherColors.primary()),
              SizedBox(
                width: 10.w,
              ),
              WeatherButton.iconButton(
                  () => controller.auth("google"),
                  SvgPicture.asset("assets/google.svg"),
                  WeatherColors.primary())
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          RichText(
              text: TextSpan(
                  text: "Don't have an account? ",
                  children: [
                    TextSpan(
                        text: "Registration",
                        style: TextStyle(color: WeatherColors.primary()),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(Routes.REGISTRATION))
                  ],
                  style: TextStyle(
                      color: WeatherColors.dark(),
                      fontSize: 14.sp,
                      letterSpacing: 0.5)))
        ],
      ),
    );
  }
}
