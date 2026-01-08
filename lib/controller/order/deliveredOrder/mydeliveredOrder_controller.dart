import 'package:admin/data/datasource/remote/order/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/model/OrderModel.dart';

class MyDeliveredOrderController extends GetxController {
  List<OrderModel> data = [];

  MyServices myServices = Get.find();

  OrderData orderData = OrderData(Get.find());

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

    var response = await orderData.getMyDeliveredOrder(
      myServices.sharedPreferences.getString("id").toString(),
      currentPage,
      pageSize,
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          data = responseData.map((e) => OrderModel.fromJson(e)).toList();
        } else if (responseData is Map) {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(responseData);
          data.add(OrderModel.fromJson(mapData));
        }
        if (data.length < pageSize) {
          hasMoreData = false; // لا توجد بيانات إضافية
        }

        currentPage += pageSize;
      } else {
        hasMoreData = false;
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void refreshData() {
    statusRequest = StatusRequest.loading;
    update();

    viewOrders();
    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void onInit() {
    viewOrders();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData) {
        viewOrders(isLoadMore: true);
      }
    });
    super.onInit();
  }
}
