import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/categories.dart';
import 'package:admin/data/model/cate2Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories2ControllerImp extends GetxController {
  List<Cate2Model> data = [];

  List<String> checkbox = [];

  late TextEditingController search;

  StatusRequest statusRequest = StatusRequest.loading;
  CategoriesData categoriesdata = CategoriesData(Get.find());

  List<bool> checkboxStates = [];

  Future<void> cate2Data() async {
    data.clear();
    var response = await categoriesdata.getCategories2(id.toString());
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => Cate2Model.fromJson(e)));
          checkboxStates.addAll(List.filled(data.length, selectAll));
          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(Cate2Model.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> searchCate2Data(String value) async {
    data.clear();
    var response = await categoriesdata.searchCategories2(value);
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => Cate2Model.fromJson(e)));
          checkboxStates.addAll(List.filled(data.length, selectAll));
          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(Cate2Model.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> deleteData() async {
    var response = await categoriesdata.deleteCategories2(checkbox.toList());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        cate2Data();
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
    var result = await Get.toNamed(AppRoute.editcate2, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cate2Data();
    }
  }

  String? ref;

  Future<void> navigateToSecondPage(dynamic arg) async {
    var result = await Get.toNamed(AppRoute.addcate2, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cate2Data();
    }
  }

  String? id;
  String? cate1;

  @override
  void onInit() {
    search = TextEditingController();
    var arg = Get.arguments;
    if (arg != null) {
      id = arg["id"];
      cate1 = arg["cate1"];
    }
    cate2Data();
    super.onInit();
  }
}
