import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckoutViewModel {
  static const String _cityUrl =
      "http://192.168.1.5:5000/api/city/shipping-cities";
  static const String _orderUrl = "http://192.168.1.5:5000/api/orders/silver";

  // جلب المدن
  Future<List> fetchCities() async {
    try {
      final response = await http.get(Uri.parse(_cityUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print("Error fetching cities: $e");
    }
    return [];
  }

  // إرسال الطلب
  Future<bool> submitOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await http.post(
        Uri.parse(_orderUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(orderData),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error submitting order: $e");
      return false;
    }
  }
}
