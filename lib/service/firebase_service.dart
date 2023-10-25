import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:weather_apps/service/storage_service.dart';
import 'package:weather_apps/utilities/exports.dart';
import 'package:weather_apps/utilities/weather_colors.dart';
import 'package:weather_apps/utilities/weather_dialog.dart';

import '../app/routes/app_pages.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> firebaseAuthPhone(
      String verificationID, String verificationCode) async {
    return await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: verificationCode));
  }

  Future<UserCredential> firebaseAuthGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential> firebaseAuthEmail(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> firebaseCreateEmail(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Penanganan otomatis jika verifikasi berhasil
        _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Penanganan kesalahan verifikasi
        Get.back();
        WeatherDialog.showDialogMessage(message: "${e.message}", status: false);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Kode terkirim
        Get.back();
        Get.bottomSheet(
            Padding(
              padding: EdgeInsets.all(20.0.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verification Code",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                  ),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    appContext: Get.context!,
                    length: 6, // Panjang kode OTP
                    onChanged: (value) {
                      // Callback ketika nilai berubah
                      print(value);
                    },
                    onCompleted: (value) async {
                      // Callback ketika semua karakter diisi
                      try {
                        await firebaseAuthPhone(verificationId, value)
                            .then((value) async {
                          if (value.user != null) {
                            await StorageService.writeStorage(
                                "user", await value.user!.getIdToken());
                            Get.offAllNamed(Routes.HOME);
                          }
                        });
                      } on FirebaseAuthException catch (e) {
                        WeatherDialog.showDialogMessage(
                            message: e.message, status: false);
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: WeatherColors.primary(),
                      selectedColor: WeatherColors.primary(),
                      inactiveColor: Colors.black,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white);
        // Lakukan sesuatu dengan verificationId, misalnya menyimpannya untuk digunakan nanti
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Get.back();

        // Timeout otomatis untuk pengambilan kode
        WeatherDialog.showDialogMessage(
            message: 'Waktu habis untuk pengambilan kode, coba lagi.',
            status: false);
      },
    );
  }
}
