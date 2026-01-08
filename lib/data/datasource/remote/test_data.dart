import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class TestData {
  Crud crud;

  TestData(this.crud);

  Future getData() async {
    var response = await crud.postData(AppLink.signup, {});
    return response.fold((l) => l, (r) => r);
  }
}
