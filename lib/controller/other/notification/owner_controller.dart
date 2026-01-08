import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/other/notification.dart';
import 'package:admin/data/model/storeOwnerModel.dart';
import 'package:get/get.dart';

class OwnerNotificationControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  List<StoreOwnerModel> data = [];
  NotificationData notificationData = NotificationData(Get.find());

  MyServices myServices = Get.find();

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();
    await getdata();
    update();
  }

  Future<void> getdata() async {
    data.clear();

    var response = await notificationData.ownerData();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data.addAll(responseData.map((e) => StoreOwnerModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(StoreOwnerModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  String? id;
  @override
  void onInit() {
    super.onInit();
    getdata();
  }
}
