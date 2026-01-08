import 'package:admin/view/screen/order/pendingStorage/storage2Order.dart';
import 'package:admin/view/screen/order/pendingStorage/storage3Order.dart';
import 'package:admin/view/screen/order/pendingStorage/storageOrder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainStorageControllerImp extends GetxController {
  int currentIndex = 0;

  final List<Widget> pages = [
    const StorageOrder(),
    const Storage2Order(),
    const Storage3Order(),
  ];

  List<Widget> tabs = [
    Tab(
      icon: const Icon(Icons.my_library_books),
      text: "order".tr,
    ),
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
}
