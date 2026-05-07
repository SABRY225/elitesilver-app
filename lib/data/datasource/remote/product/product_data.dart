import '../../../../core/class/crud.dart';

class ProductData {
  Crud crud;
  ProductData(this.crud);
  getData(var productId) async {
    var response = await crud.getData(
      "http://192.168.1.5:5000/api/products/mobile/${productId}",
    );
    return response.fold((l) => l, (r) => r);
  }
}
