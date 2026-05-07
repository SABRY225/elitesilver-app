import 'package:customer/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../data/datasource/remote/auth/signup_data.dart';
import '../../../core/class/crud.dart';

class SignUpController extends GetxController {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController address;

  SignUpData signupData = SignUpData(Crud());

  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();
    super.onInit();
  }

  // دالة تسجيل الدخول
  signUp() async {
    // 1. التحقق الأولي من الحقول
    if (email.text.isEmpty) {
      return Get.snackbar("تنبيه", "يرجى إدخال البريد الإلكتروني");
    }
    if (phone.text.isEmpty) {
      return Get.snackbar("تنبيه", "يرجى إدخال رقم الهاتف");
    }
    if (address.text.isEmpty) {
      return Get.snackbar("تنبيه", "يرجى إدخال العنوان");
    }

    // 2. تحديث الحالة إلى "تحميل"
    statusRequest = StatusRequest.loading;
    update();
    // 3. إرسال الطلب للباك اند
    var response = await signupData.postData(name.text, email.text, phone.text, address.text);
    // 4. معالجة البيانات القادمة
    statusRequest = handlingData(response);
    
    if (StatusRequest.success == statusRequest) {
        Get.offNamed(AppRoutes.otp, arguments: {
          "email": email.text
        });
    }else {
        Get.defaultDialog(
          title: "فشل الدخول",
          middleText: "البريد الالكتروني مسجل لدينا بالفعل",
          middleTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: const Color(0xFF1A1A1A),
        );
        statusRequest = StatusRequest.failure;
      }
    
    update();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    super.onClose();
  }
}