import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/other/notification.dart';
import 'package:admin/data/model/deliveryModel.dart';
import 'package:get/get.dart';

class DeliveryNotificationControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  List<DeliveryModel> data = [];
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

    var response = await notificationData.deliveryData();

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data.addAll(responseData.map((e) => DeliveryModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(DeliveryModel.fromJson(mapData));
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
