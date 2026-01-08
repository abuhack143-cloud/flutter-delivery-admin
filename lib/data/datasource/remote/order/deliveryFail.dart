import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class DeliveryfailData {
  Crud crud;
  DeliveryfailData(this.crud);

  Future getOrder(String adminid, int offset, int limit) async {
    var response = await crud.postData(AppLink.deliveryFail, {
      "adminid": adminid,
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future approveOrder(String orderid, String deliveryid, String number) async {
    var response = await crud.postData(
      AppLink.approvefailOrder,
      {
        "orderid": orderid,
        "deliveryid": deliveryid,
        "orderNumber": number,
      },
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

  Future mapDeliveryData(String id) async {
    var response = await crud.postData(
      AppLink.deliveryMap,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }
}
