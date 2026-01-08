import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/account/Account.dart';
import 'package:admin/data/model/adminModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminControllerImp extends GetxController {
  String? selectedValue;
  String? selectedLang;
 String? id;
  StatusRequest statusRequest = StatusRequest.none;

  List<AdminModel> data = [];

  MyServices myServices = Get.find();

  String? role;

  AccountData accountData = AccountData(Get.find());

  bool isDelete = false;

  Future<void> refreshData() async {
    // statusRequest = StatusRequest.loading;
    update();
    await getdata();
    update();
  }

  Future<void> getdata() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await accountData
        .admin(selectedValue != null ? selectedValue.toString() : "0");

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

  Future<void> removeAdmin(String id, String personal) async {
    isDelete = true;
    update();

    var response = await accountData.removeAdmin(id, personal);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getdata();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    isDelete = false;
    update();
  }

  Future<void> navigateToSecondPage() async {
    var result = await Get.toNamed(AppRoute.addadmin);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await getdata();
    }
  }

  List<DropdownMenuItem<String>> items = [];

  final Map<String, List<Map<String, String>>> rolePermissions = {
    "superadmin": [
      {'key': '0', 'value': 'all'.tr},
      {'key': 'superadmin', 'value': 'superadmin'.tr},
      {'key': 'admin_pro', 'value': 'admin_pro'.tr},
      {'key': 'admin_all', 'value': 'admin_all'.tr},
      {'key': 'admin_east', 'value': 'admin_east'.tr},
      {'key': 'admin_west', 'value': 'admin_west'.tr},
      {'key': 'admin_other', 'value': 'admin_other'.tr},
    ],
    "admin_pro": [
      {'key': 'admin_all', 'value': 'admin_all'.tr},
      {'key': 'admin_east', 'value': 'admin_east'.tr},
      {'key': 'admin_west', 'value': 'admin_west'.tr},
      {'key': 'admin_other', 'value': 'admin_other'.tr},
    ],
    "admin_all": [
      {'key': 'admin_east', 'value': 'admin_east'.tr},
      {'key': 'admin_west', 'value': 'admin_west'.tr},
      {'key': 'admin_other', 'value': 'admin_other'.tr},
    ],
    "admin_east": [
      {'key': 'admin_east', 'value': 'admin_east'.tr},
    ],
    "admin_west": [
      {'key': 'admin_west', 'value': 'admin_west'.tr},
    ],
    "admin_other": [
      {'key': '', 'value': ''.tr},
    ]
  };

  @override
  void onInit() {
    super.onInit();
    role = myServices.sharedPreferences.getString("role");
    accountData.crud.enableLogging();
    items = rolePermissions[role]!
        .map((item) => DropdownMenuItem<String>(
              value: item['key'],
              child: Text(item['value']!),
            ))
        .toList();
    selectedValue = rolePermissions[role]!.isNotEmpty
        ? rolePermissions[role]![0]['key']
        : null;

    getdata();
  }
}
