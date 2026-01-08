import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/categories.dart';
import 'package:admin/data/model/cate1Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories1ControllerImp extends GetxController {
  List<Cate1Model> data = [];

  List<String> checkbox = [];

  late TextEditingController search;

  StatusRequest statusRequest = StatusRequest.loading;
  CategoriesData categoriesdata = CategoriesData(Get.find());

  List<bool> checkboxStates = [];

  Future<void> cate1Data() async {
    data.clear();
    var response = await categoriesdata.getCategories1();
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => Cate1Model.fromJson(e)));
          checkboxStates.addAll(List.filled(data.length, false));
          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(Cate1Model.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> searchCate1Data(String value) async {
    data.clear();
    var response = await categoriesdata.searchCategories1(value);
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => Cate1Model.fromJson(e)));

          checkboxStates.addAll(List.filled(data.length, false));
          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(Cate1Model.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> deleteData() async {
    var response = await categoriesdata.deleteCategories1(checkbox.toList());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        checkbox.clear();
        checkboxStates.clear();
        checkboxStates.addAll(List.filled(data.length, false));
        cate1Data();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void toggleCheckbox(int index) {
    checkboxStates[index] = !checkboxStates[index];
    update();
  }

  bool selectAll = false;

  void selectAllCheckbox() {
    checkboxStates.clear();
    checkboxStates.addAll(List.filled(data.length, selectAll));
    update();
  }

  Future<void> navigateEditPage(dynamic arg) async {
    var result = await Get.toNamed(AppRoute.editcate1, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cate1Data();
    }
  }

  String? ref;

  Future<void> navigateToSecondPage() async {
    var result = await Get.toNamed(AppRoute.addcate1);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cate1Data();
    }
  }

  @override
  void onInit() {
    cate1Data();
    search = TextEditingController();
    super.onInit();
  }
}
