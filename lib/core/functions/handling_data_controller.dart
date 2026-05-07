import '../class/status_request.dart';

handlingData(response) {
  if (response is StatusRequest) {
    return response; // إذا كان هناك خطأ (Left) سيعيد الحالة مباشرة
  } else {
    return StatusRequest.success; // إذا كانت بيانات (Right) سيعيد نجاح
  }
}