import 'dart:io';
import 'package:customer/data/datasource/remote/linkapi.dart';
import 'package:http/http.dart' as http;

class CustomOrder {
  static Future<bool> submitOrder({
    required String name,
    required String phone,
    required String address,
    required String desc,
    required File imageFile,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppLink.createCustomOrder),
      );

      request.fields['customerName'] = name;
      request.fields['customerPhone'] = phone;
      request.fields['customerAddress'] = address;
      request.fields['description'] = desc;

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
      print("request ---> ${request}");
      var response = await request.send();

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Error sending order: $e");
      return false;
    }
  }
}
