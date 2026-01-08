import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class PackagingData {
  Crud crud;
  PackagingData(this.crud);

  Future getPackaging() async {
    var response = await crud.postData(AppLink.packaging, {});
    return response.fold((l) => l, (r) => r);
  }

  Future deletePackaging(String id) async {
    var response = await crud.postData(AppLink.deletePackaging, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  Future editPackaging(
    String id,
    String packaging,
    String price,
  ) async {
    var response = await crud.postData(
      AppLink.editPackaging,
      {
        "id": id,
        "packaging": packaging,
        "price": price,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future addPackaging(
    String packaging,
    String price,
  ) async {
    var response = await crud.postData(
      AppLink.addPackaging,
      {
        "packaging": packaging,
        "price": price,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
