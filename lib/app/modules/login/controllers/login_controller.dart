import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_apps/app/routes/app_pages.dart';
import 'package:weather_apps/component/weather_button.dart';
import 'package:weather_apps/component/weather_textfield.dart';
import 'package:weather_apps/service/storage_service.dart';
import 'package:weather_apps/utilities/exports.dart';
import 'package:weather_apps/service/firebase_service.dart';
import 'package:weather_apps/utilities/weather_colors.dart';
import 'package:weather_apps/utilities/weather_dialog.dart';

class LoginController extends GetxController {
  final FirebaseService firebaseService;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final isSignin = false.obs;
  LoginController({required this.firebaseService});
  @override
  void onInit() async {
    super.onInit();
    await StorageService.readStorage("user").then((value) {
      if (value.isNotEmpty) {
        Get.offAllNamed(Routes.HOME);
      }
    }).catchError((err) {
      return;
    });
  }

  showPhoneVerificationInput() {
    phoneController.text = "+62";
    Get.bottomSheet(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 30.h, bottom: 5.h),
              child: WeatherTextField(
                "Enter Phone Number",
                textEditingController: phoneController,
                obsecureText: false,
                textInputType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 5.h, bottom: 30.h),
              child: WeatherButton.normalButton(() async {
                await firebaseService
                    .verifyPhoneNumber(phoneController.text.toString());
              }, "Send Verification", WeatherColors.primary()),
            )
          ],
        ),
        backgroundColor: Colors.white);
  }

  auth(type, {email, password}) async {
    try {
      isSignin.value = true;
      User? user;
      if (type == "google") {
        await firebaseService
            .firebaseAuthGoogle()
            .then((value) => user = value.user)
            .catchError((onError) {
          return null;
        });
      }
      if (type == "emailAndPassword") {
        await firebaseService
            .firebaseAuthEmail(email, password)
            .then((value) => user = value.user);
      }

      if (user != null) {
        await StorageService.writeStorage("user", await user!.getIdToken());
        Get.offAllNamed(Routes.HOME);
      }

      isSignin.value = false;
    } on FirebaseAuthException catch (e) {
      WeatherDialog.showDialogMessage(
          message: e.credential == null
              ? "Email Not Registered Your Check Email and Password"
              : e.message,
          status: false);
      isSignin.value = false;
    }
  }
}
