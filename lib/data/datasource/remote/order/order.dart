import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class OrderData {
  Crud crud;
  OrderData(this.crud);

  ////Delivered
  Future getDeliveredOrder(int offset, int limit) async {
    var response = await crud.postData(AppLink.deliveredOrder, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future getMyDeliveredOrder(String id, int offset, int limit) async {
    var response = await crud.postData(AppLink.myDeliveredOrder, {
      "id": id,
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  ///city

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

  //City
  Future getCityOrder(String adminid, int offset, int limit) async {
    var response = await crud.postData(AppLink.cityOrder, {
      "adminid": adminid,
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future approveCityOrder(
      String orderid, String adminCityid, String storeOwnerid) async {
    var response = await crud.postData(
      AppLink.approveCityOrder,
      {
        "orderid": orderid,
        "adminCityid": adminCityid,
        "storeOwner_id": storeOwnerid,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  Future approve2CityOrder(
      String orderid, String deliveryid, String storeOwnerid) async {
    var response = await crud.postData(AppLink.approve2CityOrder, {
      "orderid": orderid,
      "deliveryid": deliveryid,
      "storeOwnerid": storeOwnerid,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future rejectCityOrder(String orderid, String status, String id) async {
    var response = await crud.postData(AppLink.rejectCity, {
      "orderid": orderid,
      "status": status,
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  //

  Future getDetail(String id) async {
    var response = await crud.postData(AppLink.ordersdetails, {"orderid": id});
    return response.fold((l) => l, (r) => r);
  }
}
