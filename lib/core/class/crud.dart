import 'dart:convert';
import 'package:dartz/dartz.dart'; // ستحتاج لإضافتها في pubspec.yaml
import 'package:http/http.dart' as http;
import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      print("Sending POST request to $linkurl with data: $data");
      // إرسال الطلب
      var response = await http.post(
        Uri.parse(linkurl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      print("HTTP Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print("Exception Error: $e");
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkurl) async {
    try {
      print("Sending GET request to $linkurl");
      // إرسال الطلب
      var response = await http.get(
        Uri.parse(linkurl),
        headers: {"Content-Type": "application/json"},
      );
      print("HTTP Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (_) {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> deleteData(String linkurl) async {
    try {
      print("Sending GET request to $linkurl");
      // إرسال الطلب
      var response = await http.delete(
        Uri.parse(linkurl),
        headers: {"Content-Type": "application/json"},
      );
      print("HTTP Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (_) {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
