import 'package:admin/controller/ordersPage_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/view/screen/order/pendingOrderCustomer/pending2Order.dart';
import 'package:admin/view/screen/order/pendingOrderCustomer/pending3Order.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainPendingCustommerControllerImp extends GetxController
    with GetSingleTickerProviderStateMixin {
  int currentIndex = 0;

  TabController? tabController;

  List<Widget> pages = [];

  List<Widget> tabs = [
    Tab(
      icon: const Icon(Icons.delivery_dining),
      text: "delivery".tr,
    ),
    Tab(
      icon: const Icon(Icons.timelapse_outlined),
      text: "Waiting_delivery".tr,
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
          TabController(length: 3, vsync: this, initialIndex: initialTabIndex);
    }

    pages = [
      Pending2OrderCustommer(
        selectedOrderId: selectedOrderId,
      ),
      Pending3OrderCustommer(
        selectedOrderId: selectedOrderId,
      ),
    ];
    Future.microtask(
        () => Get.find<OrdersPageController>().resetNoti("custommer"));

    super.onInit();
  }
}
