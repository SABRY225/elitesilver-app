import 'package:get/get.dart';
import '../../core/class/status_request.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/order_data.dart';
import '../../core/class/crud.dart';

class OrderController extends GetxController {
  OrderData orderData = OrderData(Crud());
  
  StatusRequest statusRequest = StatusRequest.none;
  List orders = [];

getData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await orderData.getData();
    print("Response: $response");
    statusRequest = handlingData(response);
    print("statusRequest: $statusRequest");

    if (StatusRequest.success == statusRequest) {
      // 1. التأكد من أن الاستجابة تحتوي على البيانات المطلوبة
      if (response['orders'] != null) {
        // 2. ✅ الحل: تفريغ القائمة القديمة قبل إضافة البيانات الجديدة
        orders.clear(); 
        
        orders.addAll(response['orders']);
        print("Orders updated, count: ${orders.length}");
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      // يمكنك هنا ترك الحالة كما هي (failure أو serverfailure) حسب handlingData
    }
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}