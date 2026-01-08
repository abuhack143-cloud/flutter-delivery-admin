import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/notification.dart';

class NotificationController extends GetxController {
  NotifyData notifyData = NotifyData(Get.find());

  List data = [];

  MyServices myServices = Get.find();

  late StatusRequest statusRequest;

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await notifyData.getData(myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getData();
    update();
    super.onInit();
  }
}
