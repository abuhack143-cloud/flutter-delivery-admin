import 'package:admin/controller/ordersPage_controller.dart';
import 'package:admin/view/screen/order/pendingOrder/pending2Order.dart';
import 'package:admin/view/screen/order/pendingOrder/pending3Order.dart';
import 'package:admin/view/screen/order/pendingOrder/pendingOrder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainPendingControllerImp extends GetxController
    with GetSingleTickerProviderStateMixin {
  int currentIndex = 0;

  TabController? tabController;

  List<Widget> pages = [];

  List<Widget> tabs = [
    Tab(
      icon: const Icon(Icons.my_library_books),
      text: "order".tr,
    ),
    Tab(
      icon: const Icon(Icons.delivery_dining),
      text: "Delivery".tr,
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
      PendingOrder(selectedOrderId: selectedOrderId.toString()),
      Pending2Order(selectedOrderId: selectedOrderId.toString()),
      Pending3Order(selectedOrderId: selectedOrderId.toString()),
    ];
    Future.microtask(
        () => Get.find<OrdersPageController>().resetNoti("pending"));

    super.onInit();
  }
}
