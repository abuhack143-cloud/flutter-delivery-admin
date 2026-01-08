import 'package:admin/core/constant/route.dart';
import 'package:admin/data/datasource/remote/order/pending3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/model/OrderModel.dart';

class Pending3OrderControllerImp extends GetxController {
  List<OrderModel> data = [];

  MyServices myServices = Get.find();

  Pending3Data orderData = Pending3Data(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

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

    var response = await orderData.getPending3Order(currentPage, pageSize);

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

  Future<void> rejectOrders(
      String orderid, String status, String storeOwnerid) async {
    var response = await orderData.rejectOrder(
      orderid,
      status,
      myServices.sharedPreferences.getString("id").toString(),
      storeOwnerid,
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        viewOrders();
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> navigateToSecondPage(dynamic arguments) async {
    var result = await Get.toNamed(AppRoute.pendingMap, arguments: arguments);
    if (result == 'refresh') {
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
