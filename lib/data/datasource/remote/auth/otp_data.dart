import '../../../../../core/class/crud.dart';

class OTPData {
  Crud crud;
  OTPData(this.crud);

  // استبدل هذا الرابط برابط السيرفر الخاص بك
  static const String linkLogin =
      "http://192.168.1.5:5000/api/auth/verify-code";

  postData(String email, String otp) async {
    var response = await crud.postData(linkLogin, {
      "email": email,
      "code": otp,
    });
    return response.fold((l) => l, (r) => r);
  }
}
