import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class MapData {
  Crud crud;
  MapData(this.crud);

  Future getData() async {
    var response = await crud.postData(
      AppLink.storeMap,
      {},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future deliveryData(String id) async {
    var response = await crud.postData(
      AppLink.deliveryMap,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future storeOwnerData(String id) async {
    var response = await crud.postData(
      AppLink.storeOwnerMap,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }
}
