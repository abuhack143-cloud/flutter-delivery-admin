import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/account/accept.dart';
import 'package:admin/data/model/deliveryModel.dart';
import 'package:get/get.dart';

class DetailProfileController extends GetxController {}

class DetailProfileControllerImp extends DetailProfileController {
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;
  String? id;
  String? deliveryName;
  DeliveryModel? data;

  AcceptData accountData = AcceptData(Get.find());

  Future<void> detailAccept() async {
    var response = await accountData.detailDeliveryAccept(
      id.toString(),
      myServices.sharedPreferences.getString("id").toString(),
      deliveryName.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        accountData.postDataToTelegram(
            '-1002559122045', "اسم عامل لتوصيل: $deliveryName");
        Get.back(result: "refresh");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  Future<void> detailReject() async {
    // data.clear();

    var response = await accountData.detailDeliveryReject(
      id.toString(),
      data!.deliveryCheckCarPic.toString(),
      data!.frontDrivingLicense.toString(),
      data!.backDrivingLicense.toString(),
      data!.carManual.toString(),
      data!.technicalInspection.toString(),
      data!.deliveryImage.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back(result: "refresh");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      id = args['id'];
      deliveryName = args["name"];
      data = args["data"];
    }

    // initialData();
    super.onInit();
  }
}
