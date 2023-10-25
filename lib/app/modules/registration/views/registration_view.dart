import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_apps/app/routes/app_pages.dart';
import 'package:weather_apps/component/weather_button.dart';
import 'package:weather_apps/component/weather_textfield.dart';
import 'package:weather_apps/utilities/weather_colors.dart';

import '../../../../utilities/exports.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            "Registration Account",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
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
              () => controller.isRegistration.value
                  ? const CircularProgressIndicator()
                  : WeatherButton.normalButton(
                      () => controller.register("emailAndPassword",
                          email: controller.emailController.text.toString(),
                          password:
                              controller.passwordController.text.toString()),
                      "Sign Up",
                      WeatherColors.primary()),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Or register with",
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
                    () => controller.register("google"),
                    SvgPicture.asset("assets/google.svg"),
                    WeatherColors.primary())
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            RichText(
                text: TextSpan(
                    text: "Already have an account? ",
                    children: [
                      TextSpan(
                          text: "Sign In",
                          style: TextStyle(color: WeatherColors.primary()),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.offAndToNamed(Routes.LOGIN))
                    ],
                    style: TextStyle(
                        color: WeatherColors.dark(),
                        fontSize: 14.sp,
                        letterSpacing: 0.5)))
          ],
        ));
  }
}
