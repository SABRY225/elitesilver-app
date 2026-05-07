import '../../../../../core/class/crud.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  // استبدل هذا الرابط برابط السيرفر الخاص بك
  static const String linkLogin = "http://192.168.1.5:5000/api/auth/login";

  postData(String email) async {
    var response = await crud.postData(linkLogin, {"email": email});
    return response.fold((l) => l, (r) => r);
  }
}
