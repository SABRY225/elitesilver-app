import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/services/local_storage.dart';

class ProfileController extends GetxController {
  // متغيرات لمراقبة الحالة وتخزين البيانات
  var orderCounter = "0".obs;
  var points = "0".obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
    fetchProfileData();
  }

  // تحميل البيانات من الذاكرة المحلية لسرعة العرض
  void loadInitialData() {
    orderCounter.value = LocalStorage.getOrderCounter() ?? "0";
    points.value = LocalStorage.getPoints() ?? "0";
  }

  // جلب البيانات من الـ API
  Future<void> fetchProfileData() async {
    try {
      isLoading(true);
      final token = LocalStorage.getToken(); // افترضنا أنك تخزن التوكن

      final response = await http.get(
        Uri.parse(
          'http://192.168.1.5:5000/api/home/orders-and-points/${LocalStorage.getUserId()}',
        ), // استبدل الرابط برابط الـ API الخاص بك
        headers: {'Authorization': 'Bearer $token'},
      );
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // تحديث القيم (افترضنا أن الأسماء في الـ API هي order_count و user_points)
        orderCounter.value = data['order_count'].toString();
        points.value = data['user_points'].toString();

        // حفظ البيانات الجديدة محلياً
        await LocalStorage.setPointAndOrders(
          points: points.value,
          orderCounter: orderCounter.value,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "فشل جلب البيانات المحدثة");
    } finally {
      isLoading(false);
    }
  }
}
