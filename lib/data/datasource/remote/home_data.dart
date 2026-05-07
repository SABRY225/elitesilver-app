import '../../../core/class/crud.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);

  getData() async {
    var response = await crud.getData("http://192.168.1.5:5000/api/home");
    return response.fold((l) => l, (r) => r);
  }
}
