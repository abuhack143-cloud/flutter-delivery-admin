import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class CancelData {
  Crud crud;
  CancelData(this.crud);

  ///Cancel
  Future getCanceledOrder(int offset, int limit) async {
    var response = await crud.postData(AppLink.canceledOrder, {
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future getMyCanceledOrder(String id, int offset, int limit) async {
    var response = await crud.postData(AppLink.mycanceledOrder, {
      "id": id,
      "offset": offset.toString(),
      "limit": limit.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  Future getData(String id) async {
    var response = await crud.postData(
      AppLink.location,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }
}
