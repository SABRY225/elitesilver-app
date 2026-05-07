import '../../../../../core/class/crud.dart';

class SignUpData {
  Crud crud;
  SignUpData(this.crud);

  // استبدل هذا الرابط برابط السيرفر الخاص بك
  static const String linkSignUp = "http://192.168.1.5:5000/api/auth/register";

  postData(String name, String email, String phone, String address) async {
    var response = await crud.postData(linkSignUp, {
      "name": name,
      "email": email,
      "phone": "+962$phone",
      "address": address,
    });
    return response.fold((l) => l, (r) => r);
  }
}
