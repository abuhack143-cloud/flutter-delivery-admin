import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/Packaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPackagingControllerImp extends GetxController {
  late TextEditingController packaging;
  late TextEditingController price;

  StatusRequest statusRequest = StatusRequest.none;

  PackagingData packagingData = PackagingData(Get.find());

  Future<void> addData() async {
    var response = await packagingData.addPackaging(
      packaging.text.toString(),
      price.text.toString(),
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
    packaging = TextEditingController();
    price = TextEditingController();

    super.onInit();
  }
}
