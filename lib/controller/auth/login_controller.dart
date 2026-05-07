import 'package:customer/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../data/datasource/remote/auth/login_data.dart';
import '../../../core/class/crud.dart';
import '../../../view/screen/auth/otp_screen.dart';
class LoginController extends GetxController {
  late TextEditingController email;

  LoginData loginData = LoginData(Crud());

  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  // دالة تسجيل الدخول
  login() async {
    // 1. التحقق الأولي من الحقول
    if (email.text.isEmpty) {
      return Get.snackbar("تنبيه", "يرجى إدخال البريد الإلكتروني");
    }

    // 2. تحديث الحالة إلى "تحميل"
    statusRequest = StatusRequest.loading;
    update();
    // 3. إرسال الطلب للباك اند
    var response = await loginData.postData(email.text);
    print("Response--: $response");

    // 4. معالجة البيانات القادمة
    statusRequest = handlingData(response);
    print("statusRequest--: $statusRequest");
    if (StatusRequest.success == statusRequest) {
      Get.offNamed(AppRoutes.otp, arguments: {"email": email.text});
    } else {
      Get.defaultDialog(
        title: "فشل الدخول",
        middleText: "البريد الإلكتروني غير مسجل لدينا",
        middleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: const Color(0xFF1A1A1A),
      );
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
}
