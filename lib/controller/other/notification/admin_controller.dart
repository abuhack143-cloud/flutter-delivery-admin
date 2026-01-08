import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/other/notification.dart';
import 'package:admin/data/model/adminModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNotificationControllerImp extends GetxController {
  String? selectedValue;

  StatusRequest statusRequest = StatusRequest.loading;

  List<AdminModel> data = [];
  NotificationData notificationData = NotificationData(Get.find());

  MyServices myServices = Get.find();

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();
    await getdata();
    update();
  }

  Future<void> getdata() async {
    data.clear();

    var response = await notificationData.admin(
        selectedValue != null ? selectedValue.toString() : "0", id.toString());

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];
        if (responseData is List) {
          data.addAll(responseData.map((e) => AdminModel.fromJson(e)));
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(AdminModel.fromJson(mapData));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  List<DropdownMenuItem>? item = [];

  String? id;
  @override
  void onInit() {
    item = [
      {'key': '0', 'value': 'all'.tr},
      {'key': 'superadmin', 'value': 'superadmin'.tr},
      {'key': 'admin_pro', 'value': 'admin_pro'.tr},
      {'key': 'Admin_east', 'value': 'admin_east'.tr},
      {'key': 'admin_west', 'value': 'admin_west'.tr},
      {'key': 'admin_other', 'value': 'admin_other'.tr},
    ]
        .map((item) => DropdownMenuItem<String>(
              value: item['key'],
              child: Text(item['value']!),
            ))
        .toList();
    var arg = Get.arguments;
    if (arg != null) {
      id = arg['id'];
    }
    super.onInit();
    getdata();
  }
}
