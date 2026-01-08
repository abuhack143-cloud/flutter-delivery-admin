import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/account/accept.dart';
import 'package:admin/data/model/storeOwnerModel.dart';
import 'package:get/get.dart';

class DetailProfileOwnerController extends GetxController {}

class DetailProfileOwnerControllerImp extends DetailProfileOwnerController {
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.loading;
  String? id;
  String? ownerName;
  StoreOwnerModel? data;

  AcceptData accountData = AcceptData(Get.find());

  Future<void> detailAccept() async {
    var response = await accountData.detailownerAccept(
      id.toString(),
      myServices.sharedPreferences.getString("id").toString(),
      ownerName.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        accountData.postDataToTelegram(
            '-1002690320426', "اسم صاحب المتجر: $ownerName");
        Get.back(result: "refresh");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  Future<void> detailReject() async {
    var response = await accountData.detailownerReject(
      id.toString(),
      data!.ownerProfile.toString(),
      data!.ownerPassportPic.toString(),
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
      ownerName = args["name"];
      data = args["data"];
    }
    accountData.crud.enableLogging();
    super.onInit();
  }
}
