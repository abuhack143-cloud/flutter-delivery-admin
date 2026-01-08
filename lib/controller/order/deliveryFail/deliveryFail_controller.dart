import 'package:admin/controller/ordersPage_controller.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/data/datasource/remote/order/deliveryFail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/model/OrderModel.dart';

class DeliveryFailControllerImp extends GetxController {
  List<OrderModel> data = [];

  MyServices myServices = Get.find();

  DeliveryfailData orderData = DeliveryfailData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController reason;

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
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.getOrder(
      myServices.sharedPreferences.getString("id").toString(),
      currentPage,
      pageSize,
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

        currentPage += pageSize;
      } else {
        hasMoreData = false;
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> navigateToSecondPage(int index) async {
    var result = await Get.toNamed(AppRoute.faildeliveryorder, arguments: {
      "orderid": data[index].orderId.toString(),
      "ownerid": data[index].orderDelivery2.toString(),
      "ordernumber": data[index].orderNumber.toString(),
    });
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

  String? selectedOrderId;
  Color color = Colors.grey.shade800;
  Color iscolor() {
    Future.delayed(const Duration(milliseconds: 400), () {
      color = Colors.transparent;
      update();
    });

    return color;
  }

  bool hasScrolled = false;

  void scrollToSelectedOrder() {
    if (selectedOrderId == null || hasScrolled) return;

    int index =
        data.indexWhere((order) => order.orderId.toString() == selectedOrderId);

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
    var arg = Get.arguments;
    if (arg != null) {
      selectedOrderId = arg['orderId'];
    }
    Future.microtask(
        () => Get.find<OrdersPageController>().resetNoti("deliveryFail"));

    super.onInit();
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }
}
