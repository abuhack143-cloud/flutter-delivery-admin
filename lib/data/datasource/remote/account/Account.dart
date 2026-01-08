import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class AccountData {
  Crud crud;
  AccountData(this.crud);

  Future deliveryData(String approve, int offset, int limit) async {
    var response = await crud.postData(
      AppLink.delivery,
      {
        "approve": approve,
        "offset": offset.toString(),
        "limit": limit.toString(),
      },
    );

    return response.fold((l) => l, (r) => r);
  }

  Future detailDelivery(String id) async {
    var response = await crud.postData(
      AppLink.detaildelivery,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future ownerData(String approve, int offset, int limit, String id) async {
    var response = await crud.postData(
      AppLink.storeOwner,
      {
        "approve": approve,
        "offset": offset.toString(),
        "limit": limit.toString(),
        "id": id,
      },
    );

    return response.fold((l) => l, (r) => r);
  }

  Future admin(String role) async {
    var response = await crud.postData(
      AppLink.admin,
      {"role": role.toString()},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future removeAdmin(String id, String personal) async {
    var response = await crud.postData(
      AppLink.removeAdmin,
      {
        "id": id,
        "personal": personal,
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}
