import 'package:admin/core/constant/route.dart';
import 'package:admin/data/datasource/remote/order/orderCustommer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/model/OrderModel.dart';

class Pending2OrderCustommerControllerImp extends GetxController {
  List<OrderModel> data = [];

  MyServices myServices = Get.find();

  OrderCustommerData orderData = OrderCustommerData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  int currentPage = 1; // صفحة البداية
  int pageSize = 20; // حجم الصفحة
  bool hasMoreData = true; // هل هناك بيانات إضافية
  final ScrollController scrollController = ScrollController();

  bool hasScrolled = false;

  void scrollToSelectedOrder(String? orderId) {
    if (orderId == null || hasScrolled) return;

    int index = data.indexWhere((order) => order.orderId.toString() == orderId);

    if (index != -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        double position = index * 460.0;
        scrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        hasScrolled = true;
      });
    }
  }

  Color color = Colors.grey.shade800;
  Color iscolor() {
    Future.delayed(const Duration(milliseconds: 400), () {
      color = Colors.transparent;
      update();
    });

    return color;
  }

  Future<void> viewOrders({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      data.clear();
      currentPage = 0;
      hasMoreData = true;
    }

    if (!hasMoreData) return;
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.getPending2Order(
      currentPage,
      pageSize,
      myServices.sharedPreferences.getString("id").toString(),
    );

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
    var result = await Get.toNamed(AppRoute.adminorder, arguments: arguments);
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

  Future<void> navigateToMap(dynamic arguments) async {
    var result =
        await Get.toNamed(AppRoute.pendingMapCustommer, arguments: arguments);
    if (result == 'refresh') {
      statusRequest = StatusRequest.loading;
      await viewOrders();
    }
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
    super.onInit();
  }
}
