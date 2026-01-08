import 'package:admin/controller/ordersPage_controller.dart';
import 'package:admin/view/screen/order/cancelOrder/cancelOrder.dart';
import 'package:admin/view/screen/order/cancelOrder/mycancelOrder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainCancelControllerImp extends GetxController
    with GetSingleTickerProviderStateMixin {
  int currentIndex = 0;

  List<Widget> pages = [];

  List<Widget> tabs = [
    Tab(
      icon: const Icon(Icons.my_library_books),
      text: "my_order".tr,
    ),
    Tab(
      icon: const Icon(Icons.all_inbox),
      text: "order_all".tr,
    ),
  ];

  void changePage(int index) {
    currentIndex = index;
    update();
  }

  TabController? tabController;

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
      const MyCancelOrder(),
      CancelOrder(
        selectedOrderId: selectedOrderId,
      ),
    ];
    Future.microtask(
        () => Get.find<OrdersPageController>().resetNoti("cancel"));

    super.onInit();
  }
}
