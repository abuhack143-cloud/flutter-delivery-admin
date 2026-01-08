import 'package:admin/controller/ordersPage_controller.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/data/datasource/remote/order/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/model/OrderModel.dart';

class CityOrderControllerImp extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<OrderModel> data = [];

  MyServices myServices = Get.find();

  OrderData orderData = OrderData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController reason;

  int currentPage = 0; // صفحة البداية
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

    var response = await orderData.getCityOrder(
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

  Future<void> approveOrders(
      String orderid, String adminCityid, String storeOwnerid) async {
    var response =
        await orderData.approveCityOrder(orderid, adminCityid, storeOwnerid);

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

  Future<void> rejectOrders(
      String orderid, String status, String adminid) async {
    var response = await orderData.rejectCityOrder(
      orderid,
      status,
      adminid,
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

  Future<void> approve2Orders(String orderid, String storeOwnerid) async {
    var response = await orderData.approve2CityOrder(
      orderid,
      storeOwnerid,
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
        await Get.toNamed(AppRoute.citydeliveryorder, arguments: arguments);
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
    reason = TextEditingController();
    viewOrders();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData) {
        viewOrders(isLoadMore: true);
      }
    });
    Future.microtask(() => Get.find<OrdersPageController>().resetNoti("city"));

    super.onInit();
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }
}
