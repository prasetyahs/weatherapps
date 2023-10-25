import 'package:get/get.dart';
import 'package:weather_apps/service/firebase_service.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(firebaseService: FirebaseService()),
    );
  }
}
