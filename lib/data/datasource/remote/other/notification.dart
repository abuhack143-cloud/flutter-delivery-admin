import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class NotificationData {
  Crud crud;
  NotificationData(this.crud);

  sendNotification(String role, String id, String title, String body) async {
    var response = await crud.postData(
      AppLink.sendNotification,
      {
        "role": role,
        "id": id,
        "title": title,
        "body": body,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  deliveryData() async {
    var response = await crud.postData(
      AppLink.deliveryNotification,
      {},
    );

    return response.fold((l) => l, (r) => r);
  }

  ownerData() async {
    var response = await crud.postData(
      AppLink.ownerNotification,
      {},
    );

    return response.fold((l) => l, (r) => r);
  }

  //

  Future admin(String role, String id) async {
    var response = await crud.postData(
      AppLink.adminNotification,
      {
        "role": role,
        "id": id,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
