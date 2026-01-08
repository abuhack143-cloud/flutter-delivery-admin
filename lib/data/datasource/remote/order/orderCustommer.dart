import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class OrderCustommerData {
  Crud crud;
  OrderCustommerData(this.crud);

  ///Pending2
  Future getPending2Order(int offset, int limit, String id) async {
    var response = await crud.postData(AppLink.pending2OrderCustommer, {
      "offset": offset.toString(),
      "limit": limit.toString(),
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future approve2Order(
      String orderid, String deliveryid, String storeOwnerid) async {
    var response = await crud.postData(AppLink.approve2OrderCustommer, {
      "orderid": orderid,
      "deliveryid": deliveryid,
      "storeOwnerid": storeOwnerid,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future rejectOrder(
      String orderid, String status, String number, String deliveryid) async {
    var response = await crud.postData(AppLink.rejectOrderCustommer, {
      "orderid": orderid,
      "status": status,
      "number": number,
      "delivery_id": deliveryid,
    });
    return response.fold((l) => l, (r) => r);
  }

//

  Future getPending3Order(int offset, int limit) async {
    var response = await crud.postData(AppLink.pending3OrderCustommer, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future getData(String id) async {
    var response = await crud.postData(
      AppLink.storeMap,
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

  Future admin(String role) async {
    var response = await crud.postData(
      AppLink.adminCity,
      {"role": role},
    );
    return response.fold((l) => l, (r) => r);
  }

  Future selectAdmin(String orderid, String id) async {
    var response = await crud.postData(
      AppLink.selectAdminCity,
      {
        "orderid": orderid,
        "id": id,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  //

  Future getDetail(String id) async {
    var response = await crud.postData(AppLink.ordersdetails, {"orderid": id});
    return response.fold((l) => l, (r) => r);
  }
}
