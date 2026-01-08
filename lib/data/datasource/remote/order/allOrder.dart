import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class AllOrderData {
  Crud crud;
  AllOrderData(this.crud);

  Future getAllOrderStatus() async {
    var response = await crud.postData(AppLink.allOrderStatus, {});
    return response.fold((l) => l, (r) => r);
  }

  Future getAllOrder(int offset, int limit) async {
    var response = await crud.postData(AppLink.allOrder, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
