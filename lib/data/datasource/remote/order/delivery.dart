import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class DeliveryData {
  Crud crud;
  DeliveryData(this.crud);

  ////delivery
  Future getToAdminOrder(int offset, int limit) async {
    var response = await crud.postData(AppLink.toAdminOrder, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future getToCustommerOrder(int offset, int limit) async {
    var response = await crud.postData(AppLink.toCustommerOrder, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future ownerData(String id) async {
    var response = await crud.postData(
      AppLink.storeOwnerMap,
      {"id": id},
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

  //
}
