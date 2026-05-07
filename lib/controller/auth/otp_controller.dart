import 'package:customer/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../data/datasource/remote/auth/otp_data.dart';
import '../../../core/class/crud.dart';
import '../../core/services/local_storage.dart';

class OtpController extends GetxController {
  // 4 خانات OTP
  List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  OTPData otpData = OTPData(Crud());

  StatusRequest statusRequest = StatusRequest.none;

  // جمع الكود
  String get otpCode => otpControllers.map((e) => e.text).join();

  otp() async {
    // التأكد من الكود
    if (otpCode.length < 4) {
      return Get.snackbar("تنبيه", "أدخل رمز التحقق كامل");
    }

    var email = Get.arguments?["email"];
    if (email == null) {
      Get.snackbar("Error", "Email not found");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await otpData.postData(email, otpCode);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      await LocalStorage.setUser(
        token: response['token'] ?? '',
        email: email,
        name: response['user']['name'] ?? '',
        userId: response['user']['id'] ?? '',
        points: response['user']['points']?.toString() ?? '0',
        orderCounter: response['user']['orderCounter']?.toString() ?? '0',
      );

      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.defaultDialog(
        title: "فشل الدخول",
        middleText: "رمز التحقق غير صحيح",
        middleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: const Color(0xFF1A1A1A),
      );
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  void onClose() {
    for (var c in otpControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
