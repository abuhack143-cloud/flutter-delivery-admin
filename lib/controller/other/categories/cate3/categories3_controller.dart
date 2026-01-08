import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/data/datasource/remote/other/categories.dart';
import 'package:admin/data/model/cate3Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories3ControllerImp extends GetxController {
  List<Cate3Model> data = [];

  List<String> checkbox = [];

  late TextEditingController search;

  StatusRequest statusRequest = StatusRequest.loading;
  CategoriesData categoriesdata = CategoriesData(Get.find());

  List<bool> checkboxStates = [];

  Future<void> cateData() async {
    data.clear();
    var response = await categoriesdata.getCategories3(id.toString());
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => Cate3Model.fromJson(e)));
          checkboxStates.addAll(List.filled(data.length, selectAll));
          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(Cate3Model.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> searchCate2Data(String value) async {
    data.clear();
    var response = await categoriesdata.searchCategories3(value);
    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data.addAll(responseData.map((e) => Cate3Model.fromJson(e)));
          checkboxStates.addAll(List.filled(data.length, selectAll));
          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(Cate3Model.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> deleteData() async {
    var response = await categoriesdata.deleteCategories3(checkbox.toList());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        cateData();
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
    var result = await Get.toNamed(AppRoute.editcate3, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cateData();
    }
  }

  String? ref;

  Future<void> navigateToSecondPage(dynamic arg) async {
    var result = await Get.toNamed(AppRoute.addcate3, arguments: arg);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await cateData();
    }
  }

  String? id;
  String? cate2;
  String? cate1;

  @override
  void onInit() {
    search = TextEditingController();
    var arg = Get.arguments;
    if (arg != null) {
      id = arg["id"];
      cate2 = arg["cate2"];
      cate1 = arg["cate1"];
    }
    cateData();
    super.onInit();
  }
}
