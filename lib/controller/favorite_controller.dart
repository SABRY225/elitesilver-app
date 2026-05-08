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

    favoritesList.clear(); 

    final int? userId = LocalStorage.getUserId();
    final String id = userId.toString();

    var response = await favoriteData.getData(id);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        favoritesList.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  removeFromFavorite(String favId) async {
    var response = await favoriteData.removeData(favId);

    if (response['status'] == "success") {
      Get.snackbar("favorites".tr, "Deleted successfully".tr, 
          snackPosition: SnackPosition.BOTTOM);
      
      getFavorites();
    } else {
      Get.snackbar("Error".tr, "Deletion failed, please try again".tr);
    }
  }
}