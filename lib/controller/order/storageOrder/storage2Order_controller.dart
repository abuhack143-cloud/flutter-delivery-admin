import 'package:admin/core/constant/route.dart';
import 'package:admin/data/datasource/remote/order/storage.dart';
import 'package:admin/data/model/storageordermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';

class Storage2OrderControllerImp extends GetxController {
  List<StorageOrderModel> data = [];

  MyServices myServices = Get.find();

  StorageData storageData = StorageData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  int currentPage = 0; // صفحة البداية
  int pageSize = 20; // حجم الصفحة
  bool hasMoreData = true; // هل هناك بيانات إضافية
  final ScrollController scrollController = ScrollController();

  Future<void> viewOrders({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      data.clear();
      currentPage = 0;
      hasMoreData = true;
    }

    if (!hasMoreData) return;

    var response = await storageData.getStorage2Order(
      currentPage,
      pageSize,
      myServices.sharedPreferences.getString("id").toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data =
              responseData.map((e) => StorageOrderModel.fromJson(e)).toList();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(StorageOrderModel.fromJson(mapData));
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

  Future<void> rejectOrders(String orderid, String status) async {
    var response = await storageData.rejectOrder(
      orderid,
      status,
      myServices.sharedPreferences.getString("id").toString(),
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        viewOrders();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> navigateToSecondPage(dynamic arguments) async {
    var result =
        await Get.toNamed(AppRoute.mapDeliveryStorage, arguments: arguments);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await viewOrders();
    }
  }

  Future<void> navigateToDeliveryPage(dynamic arguments) async {
    var result = await Get.toNamed(
      AppRoute.pendingdelivery,
      arguments: arguments,
    );
    if (result == 'refresh') {
      Navigator.of(Get.context!).pop();
      statusRequest = StatusRequest.loading;
      await viewOrders();
    }
  }

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();

    await viewOrders();
  }

  @override
  void onInit() {
    viewOrders();
    super.onInit();
  }
}
