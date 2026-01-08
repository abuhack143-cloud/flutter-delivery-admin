import 'package:admin/controller/ordersPage_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/view/screen/order/deliveryOrder/toAdminOrder.dart';
import 'package:admin/view/screen/order/deliveryOrder/toCustommerOrder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainDeliveryControllerImp extends GetxController
    with GetSingleTickerProviderStateMixin {
  int currentIndex = 0;

  TabController? tabController;

  List<Widget> pages = [];

  List<Widget> tabs = [
    Tab(
      icon: const Icon(Icons.my_library_books),
      text: "ToAdmin".tr,
    ),
    Tab(
      icon: const Icon(Icons.person),
      text: "ToCustommer".tr,
    ),
  ];

  void changePage(int index) {
    currentIndex = index;
    update();
  }

  String? selectedOrderId;
  int initialTabIndex = 0;

  MyServices myServices = Get.find();


  @override
  void onInit() {
    final arg = Get.arguments;
    if (arg != null) {
      selectedOrderId = arg["orderId"];
      initialTabIndex = int.tryParse(arg["targetTab"]) ?? 0;
      tabController =
          TabController(length: 2, vsync: this, initialIndex: initialTabIndex);
    }

    pages = [
      ToAdminOrder(
        selectedOrderId: selectedOrderId,
      ),
      ToCustommerOrder(
        selectedOrderId: selectedOrderId,
      ),
    ];
    Future.microtask(
        () => Get.find<OrdersPageController>().resetNoti("delivering"));

    super.onInit();
  }
}
