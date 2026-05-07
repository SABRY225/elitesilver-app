import 'package:customer/core/services/local_storage.dart';
import 'package:get/get.dart';
import '../../core/class/status_request.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/favorite_data.dart';
import '../../core/class/crud.dart';

class FavoriteController extends GetxController {
  FavoriteData favoriteData = FavoriteData(Crud());
  List favoritesList = [];
  late StatusRequest statusRequest;

  @override
  void onInit() {
    getFavorites();
    super.onInit();
  }

  getFavorites() async {
    statusRequest = StatusRequest.loading;
    update();

    // 1. الحل السحري: تفريغ القائمة قبل إضافة البيانات الجديدة
    favoritesList.clear(); 

    final int? userId = LocalStorage.getUserId();
    final String id = userId.toString();

    var response = await favoriteData.getData(id);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        favoritesList.addAll(response['data']);
      } else {
        // إذا لم توجد بيانات، نترك القائمة فارغة ونضع حالة failure أو success
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  removeFromFavorite(String favId) async {
    // 2. يفضل عدم جعل الشاشة كاملة "Loading" عند الحذف لتجربة مستخدم أفضل
    // بل نكتفي بإظهار Snackbar أو مؤشر صغير
    var response = await favoriteData.removeData(favId);

    if (response['status'] == "success") {
      Get.snackbar("المفضلة", "تم الحذف بنجاح", 
          snackPosition: SnackPosition.BOTTOM);
      
      // تحديث القائمة فوراً بعد الحذف الناجح
      getFavorites();
    } else {
      Get.snackbar("خطأ", "فشل الحذف، حاول مرة أخرى");
    }
  }
}