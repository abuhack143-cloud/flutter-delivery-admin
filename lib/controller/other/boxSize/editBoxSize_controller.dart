import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/boxSize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBoxSizeControllerImp extends GetxController {
  String? theSize;

  String? id;
  late TextEditingController size;
  late TextEditingController width;
  late TextEditingController length;
  late TextEditingController height;
  late TextEditingController weight;
  late TextEditingController price;

  StatusRequest statusRequest = StatusRequest.none;

  BoxSizeData boxData = BoxSizeData(Get.find());

  Future<void> editBoxSizeData() async {
    var response = await boxData.editBoxSize(
      id.toString(),
      size.text.toString(),
      width.text.toString(),
      length.text.toString(),
      height.text.toString(),
      weight.text.toString(),
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
    size = TextEditingController();
    width = TextEditingController();
    length = TextEditingController();
    height = TextEditingController();
    weight = TextEditingController();
    price = TextEditingController();

    var arg = Get.arguments;

    if (arg != null) {
      id = arg['id'];
      size.text = arg['size'];
      width.text = arg['width'];
      length.text = arg['length'];
      height.text = arg['height'];
      weight.text = arg['weight'];
      price.text = arg['price'];
      theSize = arg['size'];
    }

    super.onInit();
  }
}
