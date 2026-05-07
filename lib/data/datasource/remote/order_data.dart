import '../../../core/class/crud.dart';
import '../../../core/services/local_storage.dart';

class OrderData {
  Crud crud;
  OrderData(this.crud);
  var userId = LocalStorage.getUserId();
  getData() async {
    var response = await crud.getData(
      "http://192.168.1.5:5000/api/orders/mobile/${userId}",
    );
    return response.fold((l) => l, (r) => r);
  }
}
