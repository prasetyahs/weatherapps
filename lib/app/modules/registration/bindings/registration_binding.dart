import 'package:get/get.dart';
import 'package:weather_apps/service/firebase_service.dart';

import '../controllers/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(FirebaseService()),
    );
  }
}
