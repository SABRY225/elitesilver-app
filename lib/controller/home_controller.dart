import 'dart:async'; 
import 'package:get/get.dart';
import '../core/class/status_request.dart';
import '../core/functions/handling_data_controller.dart';
import '../data/datasource/remote/home_data.dart';
import '../core/class/crud.dart';

class HomeController extends GetxController {
  HomeData homeData = HomeData(Crud());
  StatusRequest statusRequest = StatusRequest.none;

  List categories = [];
  List products = [];
  List investmentProducts = [];

  Timer? _timer;

  getData({bool showLoading = true}) async {
    if (showLoading) {
      statusRequest = StatusRequest.loading;
      update();
    }

    var response = await homeData.getData();

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      categories.clear();
      products.clear();
      investmentProducts.clear();

      categories.addAll(response['categories']);
      products.addAll(response['products']);
      investmentProducts.addAll(response['investment']);
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  void startPolling() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      getData(showLoading: false); 
    });
  }

  @override
  void onInit() {
    getData(); 
    startPolling();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel(); 
    super.onClose();
  }
}