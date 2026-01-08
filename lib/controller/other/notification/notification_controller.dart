import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/other/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  String? selectedValue;

  int? group = 2;
  bool isRadioError = false;

  late TextEditingController title;
  late TextEditingController body;

  bool account = false;

  bool titletf = false;
  bool bodytf = false;
  bool button() {
    bool groupTF;
    bool special;
    bool value;

    groupTF = group != null;
    // q = group == 1 && adminid != null;
    value = selectedValue != null;

    special = group == 2 ? true : id != null;
    bool all;
    all = groupTF && special && value && titletf && bodytf;
    update();
    return all;
  }

  List<DropdownMenuItem<String>> items = [
    {'key': 'All', 'value': 'all'.tr},
    {'key': 'delivery', 'value': 'Delivery'.tr},
    {'key': 'storeOwner', 'value': 'store_owner'.tr},
    {'key': 'admin', 'value': 'admin'.tr},
  ]
      .map((item) => DropdownMenuItem<String>(
            value: item['key'],
            child: Text(item['value']!),
          ))
      .toList();

  String? id;

  Future<void> navigateToAdmin() async {
    var result = await Get.toNamed(AppRoute.adminnotification,
        arguments: {"id": myServices.sharedPreferences.getString("id")});
    id = result;
    update();
  }

  Future<void> navigateToDelivery() async {
    var result = await Get.toNamed(AppRoute.deliverynotification);
    id = result;
    update();
  }

  Future<void> navigateToOwner() async {
    var result = await Get.toNamed(AppRoute.ownernotification);
    id = result;
    update();
  }

  void selcetnavigate() {
    if (selectedValue == "admin") {
      navigateToAdmin();
    } else if (selectedValue == "delivery") {
      navigateToDelivery();
    } else if (selectedValue == "storeOwner") {
      navigateToOwner();
    }
  }

  StatusRequest statusRequest = StatusRequest.loading;

  NotificationData notificationData = NotificationData(Get.find());

  MyServices myServices = Get.find();

  Future<void> sendData() async {
    var response = await notificationData.sendNotification(
      selectedValue != null ? selectedValue.toString() : "All",
      id != null ? id.toString() : "",
      title.text,
      body.text,
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
    print(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        selectedValue = null;
        id = null;
        group = 2;
        title.text = "";
        body.text = "";
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  @override
  void onInit() {
    items;
    title = TextEditingController();
    body = TextEditingController();
    super.onInit();
  }
}
