import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/categories.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddCategories2ControllerImp extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController cate2;

  StatusRequest statusRequest = StatusRequest.loading;
  CategoriesData categoriesdata = CategoriesData(Get.find());


 

  Future<void> addCateData() async {
    var response =
        await categoriesdata.addCategories2(cate1.toString(), cate2.text.toString());
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
String? cate1;
  @override
  void onInit() {
    cate2 = TextEditingController();
    var arg = Get.arguments;

    if (arg != null) {

      cate1 = arg["cate1"];
    }
   
    super.onInit();
  }
}
