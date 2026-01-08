import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/account/Account.dart';
import 'package:admin/data/model/storeOwnerModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreOwnerControllerImp extends GetxController {
  String? selectedValue;
  String? selectedLang;

  StatusRequest statusRequest = StatusRequest.loading;

  MyServices myServices = Get.find();

  List<StoreOwnerModel> data = [];

  AccountData accountData = AccountData(Get.find());

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();
    await getdata();
    update();
  }

  int currentPage = 0; // صفحة البداية
  int pageSize = 20; // حجم الصفحة
  bool hasMoreData = true; // هل هناك بيانات إضافية
  final ScrollController scrollController = ScrollController();

  Future<void> getdata({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      data.clear();
      currentPage = 0;
      hasMoreData = true;
    }

    if (!hasMoreData) return;

    var response = await accountData.ownerData(
      selectedValue != null ? selectedValue! : "1",
      currentPage,
      pageSize,
      myServices.sharedPreferences.getString("id").toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);
    print(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data = responseData.map((e) => StoreOwnerModel.fromJson(e)).toList();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(StoreOwnerModel.fromJson(mapData));
        }
        if (data.length < pageSize) {
          hasMoreData = false; // لا توجد بيانات إضافية
        }

        currentPage = currentPage + 20; // زيادة الصفحة
        pageSize = pageSize + 20;
      } else {
        hasMoreData = false;
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> navigateToSecondPage(dynamic arguments) async {
    var result = await Get.toNamed(AppRoute.detailowner, arguments: arguments);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await getdata();
    }
  }

  List<DropdownMenuItem<String>> items = [];
  @override
  void onInit() {
    super.onInit();

    if (myServices.sharedPreferences.getString("role") == 'admin_east' ||
        myServices.sharedPreferences.getString("role") == 'admin_west') {
      items = [
        {'key': '2', 'value': 'accepted'.tr}, // "مقبول"
      ]
          .map((item) => DropdownMenuItem<String>(
                value: item['key'],
                child: Text(item['value']!),
              ))
          .toList();
      selectedValue = '2';
    } else {
      items = [
        {'key': '1', 'value': 'not_accepted'.tr}, // "غير مقبول"
        {'key': '2', 'value': 'accepted'.tr}, // "مقبول"
      ]
          .map((item) => DropdownMenuItem<String>(
                value: item['key'],
                child: Text(item['value']!),
              ))
          .toList();
    }
    getdata();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData) {
        getdata(isLoadMore: true);
      }
    });
  }
}
