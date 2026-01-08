import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class NotifyData {
  Crud crud;

  NotifyData(this.crud);

  Future getData(String id) async {
    var response = await crud.postData(AppLink.notification, {"id": id});
    return response.fold((l) => l, (r) => r);
  }
}
