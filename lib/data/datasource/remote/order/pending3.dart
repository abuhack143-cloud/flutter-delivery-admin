import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class Pending3Data {
  Crud crud;

  Pending3Data(this.crud);

  Future getPending3Order(int offset, int limit) async {
    var response = await crud.postData(AppLink.pending3Order, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future rejectOrder(
      String orderid, String status, String id, String storeOwnerid) async {
    var response = await crud.postData(AppLink.reject, {
      "orderid": orderid,
      "status": status,
      "id": id,
      "storeOwner_id": storeOwnerid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
