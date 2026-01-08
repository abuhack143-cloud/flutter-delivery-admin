import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class StorageData {
  Crud crud;
  StorageData(this.crud);

  Future getStorageOrder(int offset, int limit) async {
    var response = await crud.postData(AppLink.storageOrder, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future approveOrder(
      String orderid, String storeOwnerid, String adminid) async {
    var response = await crud.postData(AppLink.approveStorage, {
      "orderid": orderid,
      "storeOwnerid": storeOwnerid,
      "adminid": adminid,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future rejectOrder(String orderid, String status, String id) async {
    var response = await crud.postData(AppLink.rejectStorage, {
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

  //Storage 2
  Future getStorage2Order(int offset, int limit, String id) async {
    var response = await crud.postData(AppLink.storage2Order, {
      "offset": offset.toString(),
      "limit": limit.toString(),
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future approve2Order(
      String orderid, String deliveryid, String storeOwnerid) async {
    var response = await crud.postData(AppLink.approve2Storage, {
      "orderid": orderid,
      "deliveryid": deliveryid,
      "storeOwnerid": storeOwnerid,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future deliveryData(String id) async {
    var response = await crud.postData(
      AppLink.deliveryMap,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }

  //Storage 3
  Future getStorage3Order(int offset, int limit) async {
    var response = await crud.postData(AppLink.storage3Order, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future getDetail(String id) async {
    var response = await crud.postData(AppLink.storageDetails, {"orderid": id});
    return response.fold((l) => l, (r) => r);
  }
}
