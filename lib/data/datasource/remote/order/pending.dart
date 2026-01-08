import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class PendingData {
  Crud crud;

  PendingData(this.crud);

  Future getPendingOrder(int offset, int limit) async {
    var response = await crud.postData(AppLink.pendingOrder, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future approveOrder(
      String orderid, String storeOwnerid, String adminid) async {
    var response = await crud.postData(AppLink.approveOrder, {
      "orderid": orderid,
      "storeOwnerid": storeOwnerid,
      "adminid": adminid,
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
