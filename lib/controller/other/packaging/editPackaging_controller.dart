import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/Packaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPackagingControllerImp extends GetxController {
  String? theSize;

  String? id;
  late TextEditingController packaging;
  late TextEditingController price;

  StatusRequest statusRequest = StatusRequest.none;

  PackagingData packagingData = PackagingData(Get.find());

  Future<void> editData() async {
    var response = await packagingData.editPackaging(
      id.toString(),
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

    var arg = Get.arguments;

    if (arg != null) {
      id = arg['id'];
      packaging.text = arg['packaging'];
      price.text = arg['price'];
      theSize = arg['packaging'];
    }

    super.onInit();
  }
}
