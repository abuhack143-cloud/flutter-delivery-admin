import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/categories.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditCategories1ControllerImp extends GetxController {
  String? theCate1;
  String? id;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController cate1Name;

  StatusRequest statusRequest = StatusRequest.loading;

  CategoriesData categoriesdata = CategoriesData(Get.find());

  Future<void> editCate1() async {
    var response = await categoriesdata.editCategories1(
      id.toString(),
      cate1Name.text.toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back(result: 'refresh');
      } else {
        Get.back();
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    cate1Name = TextEditingController();
    var arg = Get.arguments;

    if (arg != null) {
      id = arg['id'];
      cate1Name.text = arg['cate1'];
      theCate1 = arg['cate1'];
    }

    super.onInit();
  }
}
