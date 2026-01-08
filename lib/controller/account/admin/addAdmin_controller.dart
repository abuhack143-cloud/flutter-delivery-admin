import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/account/add_admin.dart';
import 'package:admin/data/model/OrderCityModel.dart';
import 'package:admin/data/model/storeOwnerModel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddadminController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String? selectedValue;

  MyServices myServices = Get.find();

  late TextEditingController name;
  late TextEditingController branch;
  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  void showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  List<SelectedListItem> city = [];
  List<String> selectcity = [];
  String selectedCity = '';
  List<OrderCityModel> dataCity = [];

  bool isCityError = false;

  List<SelectedListItem> ownerListItem = [];
  List<String> listOwner = [];
  List<String> stringOwner = [];
  List<StoreOwnerModel> dataOwner = [];

  bool isOwnerError = false;

  StatusRequest statusRequest = StatusRequest.none;
  AddAdminData accountData = AddAdminData(Get.find());

  Future<void> cityData() async {
    dataCity.clear();

    statusRequest = StatusRequest.loading;
    update();
    var response = await accountData.getCity();

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          dataCity.addAll(responseData.map((e) => OrderCityModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          dataCity.add(OrderCityModel.fromJson(mapData));
        }

        if (dataCity.isNotEmpty) {
          city = dataCity
              .map((item) => SelectedListItem(
                  data: "${item.cityName}", value: "${item.classification}"))
              .toList();
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> ownerData() async {
    dataOwner.clear();
    ownerListItem.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await accountData.getOwner(selectcity);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          dataOwner
              .addAll(responseData.map((e) => StoreOwnerModel.fromJson(e)));

          update();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          dataOwner.add(StoreOwnerModel.fromJson(mapData));
        }

        if (dataOwner.isNotEmpty) {
          ownerListItem = dataOwner
              .map((item) => SelectedListItem(
                  data:
                      "${item.ownerStoreName} - ${item.cityName} (${item.ownerName})",
                  value: "${item.ownerId}"))
              .toList();
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> addAdmin() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      if (selectcity.isEmpty && selectedValue == "admin_other") {
        isCityError = true;
        update();
        return;
      } else {
        isCityError = false;
        update();
      }
      if (listOwner.isEmpty && selectedValue == "admin_other") {
        isOwnerError = true;

        update();
        return;
      } else {
        isOwnerError = false;
        update();
      }
      statusRequest = StatusRequest.loading;
      update();
      var response = await accountData.addAdminWithR2(
        name: name.text.toString(),
        email: email.text.toString(),
        password: password.text.toString(),
        branch: branch.text.toString(),
        role: selectedValue != null ? selectedValue.toString() : "0",
      );

      statusRequest = handlingData(response.fold((l) => l, (r) => r));

      response.fold(
        (_) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content: Text("Something_went_wrong".tr)),
          );
          statusRequest = StatusRequest.failure;
          update();
        },
        (resp) {
          if (resp['status'] == 'success') {
            if (selectedValue == "admin_other" && selectcity.isNotEmpty) {
              addOtherAdmin();
            } else {
              Get.back(result: "refresh");
            }
          } else {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Something_went_wrong".tr)),
            );
            statusRequest = StatusRequest.failure;
            update();
          }
        },
      );

      // if (StatusRequest.success == statusRequest) {
      //   if (response['status'] == "success") {
      //     if (selectedValue == "admin_other" && selectcity.isNotEmpty) {
      //       addOtherAdmin();
      //     } else {
      //       Get.back(result: "refresh");
      //     }
      //   } else {
      //     statusRequest = StatusRequest.failure;
      //   }
      // }

      update();
    }
  }

  Future<void> addOtherAdmin() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await accountData.addOtherAdmin(email.text.toString(), stringOwner);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  List<DropdownMenuItem<String>> items = [];
  String? role;
  @override
  void onInit() {
    name = TextEditingController();
    branch = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    role = myServices.sharedPreferences.getString("role").toString();
    if (role == "superadmin") {
      items = [
        {'key': 'superadmin', 'value': 'superadmin'.tr},
        {'key': 'admin_pro', 'value': 'admin_pro'.tr},
        {'key': 'admin_all', 'value': 'admin_all'.tr},
        {'key': 'admin_east', 'value': 'admin_east'.tr},
        {'key': 'admin_west', 'value': 'admin_west'.tr},
        {'key': 'admin_other', 'value': 'admin_other'.tr},
      ]
          .map((item) => DropdownMenuItem<String>(
                value: item['key'],
                child: Text(item['value']!),
              ))
          .toList();
    } else if (role == "admin_pro") {
      items = [
        {'key': 'admin_all', 'value': 'admin_all'.tr},
        {'key': 'admin_east', 'value': 'admin_east'.tr},
        {'key': 'admin_west', 'value': 'admin_west'.tr},
        {'key': 'admin_other', 'value': 'admin_other'.tr},
      ]
          .map((item) => DropdownMenuItem<String>(
                value: item['key'],
                child: Text(item['value']!),
              ))
          .toList();
    }

    super.onInit();
  }
}
