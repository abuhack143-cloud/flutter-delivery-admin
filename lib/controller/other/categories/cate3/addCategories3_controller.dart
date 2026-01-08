import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/categories.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddCategories3ControllerImp extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController cate3;

  StatusRequest statusRequest = StatusRequest.loading;
  CategoriesData categoriesdata = CategoriesData(Get.find());

  Future<void> addCateData() async {
    var response = await categoriesdata.addCategories3(
      cate3.text.toString(),
      id.toString(),
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

  String? id;
  @override
  void onInit() {
    cate3 = TextEditingController();
    var arg = Get.arguments;

    if (arg != null) {
      id = arg["id"];
    }

    super.onInit();
  }
}
