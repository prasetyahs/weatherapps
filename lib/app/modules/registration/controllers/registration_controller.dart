import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_apps/service/firebase_service.dart';
import 'package:weather_apps/service/storage_service.dart';
import 'package:weather_apps/utilities/weather_colors.dart';
import 'package:weather_apps/utilities/weather_dialog.dart';

import '../../../../component/weather_button.dart';
import '../../../../component/weather_textfield.dart';
import '../../../../utilities/exports.dart';
import '../../../routes/app_pages.dart';

class RegistrationController extends GetxController {
  //TODO: Implement RegistrationController

  final count = 0.obs;
  final FirebaseService _firebaseService = FirebaseService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final FirebaseService firebaseService;
  final isRegistration = false.obs;

  RegistrationController(this.firebaseService);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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

  void increment() => count.value++;

  register(type, {email, password}) async {
    try {
      isRegistration.value = true;
      if (type == "google") {
        await _firebaseService.firebaseAuthGoogle().then((value) async {
          if (value.user != null) {
            await StorageService.writeStorage(
                "user", await value.user!.getIdToken());

            Get.offAllNamed(Routes.HOME);
          }
        }).catchError((onError) {
          return null;
        });
      }

      if (type == "emailAndPassword") {
        await _firebaseService
            .firebaseCreateEmail(email, password)
            .then((value) {
          if (value.user != null) {
            WeatherDialog.showDialogMessage(
                message: "Registration Success", status: true);
            Get.back();
          }
        });
      }
      isRegistration.value = false;
    } on FirebaseAuthException catch (e) {
      WeatherDialog.showDialogMessage(message: e.message, status: false);
      isRegistration.value = false;
    }
  }
}
