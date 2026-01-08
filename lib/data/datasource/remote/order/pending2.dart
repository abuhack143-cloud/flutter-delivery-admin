import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class Pending2Data {
  Crud crud;
  Pending2Data(this.crud);

  Future getPending2Order(int offset, int limit, String id) async {
    var response = await crud.postData(AppLink.pending2Order, {
      "offset": offset.toString(),
      "limit": limit.toString(),
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future deliveryData() async {
    var response = await crud.postData(
      AppLink.deliveryPending,
      {},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future deliverymap(String id) async {
    var response = await crud.postData(
      AppLink.deliveryMap,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future getData(String id) async {
    var response = await crud.postData(
      AppLink.storeMap,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future approve2Order(String orderid, String deliveryid, String storeOwnerid,
      String orderNumber) async {
    var response = await crud.postData(AppLink.approve2Order, {
      "orderid": orderid,
      "deliveryid": deliveryid,
      "storeOwnerid": storeOwnerid,
      "orderNumber": orderNumber,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future rejectOrder(String orderid, String status, String id) async {
    var response = await crud.postData(AppLink.reject, {
      "orderid": orderid,
      "status": status,
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future reasonOrder(
    String theReason,
    String userid,
    String orderId,
  ) async {
    var response = await crud.postData(AppLink.reasonRejectOrder, {
      "reason_theReason": theReason,
      "reason_user": "admin",
      "reason_userid": userid,
      "reason_orderid": orderId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
