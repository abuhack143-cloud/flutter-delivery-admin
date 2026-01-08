import 'package:admin/controller/home_controller.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/data/datasource/remote/order/allOrder.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/model/OrderModel.dart';

class AllOrderController extends GetxController {}

class AllOrderControllerImp extends AllOrderController {
  int touchedIndex = -1;

  int? notApprovedCount;
  int? approvedCount;
  int? received;
  int? city;
  int? delivered;
  int? fail;
  int? deliveryAccept;
  int? deliveryToAdmin;
  int? deliveryToCustomer;
  int? deliveredNoCity;

  List<OrderModel> data = [];
  MyServices myServices = Get.find();
  AllOrderData ordersData = AllOrderData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  int currentPage = 0; // صفحة البداية
  int pageSize = 10; // حجم الصفحة
  bool hasMoreData = true; // هل هناك بيانات إضافية
  final ScrollController scrollController = ScrollController();

  Future<void> refreshData() async {
    statusRequest = StatusRequest.loading;
    update();

    await orderStatus();
    await viewOrders();
    statusRequest = StatusRequest.success;
    update();
  }

  Future<void> viewOrders({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      data.clear();
      currentPage = 0;
      hasMoreData = true;
    }

    if (!hasMoreData) return;

    var response = await ordersData.getAllOrder(currentPage, pageSize);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          List<OrderModel> newData =
              responseData.map((e) => OrderModel.fromJson(e)).toList();

          if (newData.length < pageSize) {
            hasMoreData = false;
          }

          data.addAll(newData);
          currentPage += pageSize;
        }
      } else {
        hasMoreData = false;
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> orderStatus() async {
    var response = await ordersData.getAllOrderStatus();
    statusRequest = StatusRequest.loading;
    update();

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        notApprovedCount = response['notApprove'];
        approvedCount = response['Approve'];
        deliveryAccept = response['DeliveryAccept'];
        received = response['received'];
        deliveryToAdmin = response['deliveryToAdmin'];
        deliveryToCustomer = response['deliveryToCustomer'];
        deliveredNoCity = response['deliveredNoCity'];
        city = response['city'];
        delivered = response['delivered'];
        fail = response['fail'];
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void pages() {
    if (touchedIndex == 0) {
      Get.toNamed(AppRoute.mainpending);
    }
    if (touchedIndex == 1) {
      Get.toNamed(
        AppRoute.mainpending,
        arguments: {
          "targetTab": "1",
        },
      );
    }

    if (touchedIndex == 2) {
      Get.toNamed(AppRoute.mainDelivery);
    }
    if (touchedIndex == 3) {
      Get.toNamed(
        AppRoute.mainDelivery,
        arguments: {
          "targetTab": "1",
        },
      );
    }

    if (touchedIndex == 4 && touchedIndex == 7) {
      Get.toNamed(AppRoute.cityorder);
    }

    if (touchedIndex == 5) {
      Get.toNamed(AppRoute.mainpendingCustommer);
    }

    if (touchedIndex == 6) {
      Get.toNamed(AppRoute.mainDelivery);
    }

    if (touchedIndex == 8) {
      Get.toNamed(AppRoute.maindelivered);
    }
    if (touchedIndex == 9) {
      Get.toNamed(AppRoute.deliveryFail);
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(10, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Appcolor.red,
            value: (notApprovedCount ?? 0).toDouble(),
            title: '${notApprovedCount ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: (approvedCount ?? 0).toDouble(),
            title: '${approvedCount ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue.shade700,
            value: (deliveryAccept ?? 0).toDouble(),
            title: '${deliveryAccept ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: (received ?? 0).toDouble(),
            title: '${received ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.teal,
            value: (deliveryToAdmin ?? 0).toDouble(),
            title: '${deliveryToAdmin ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 5:
          return PieChartSectionData(
            color: Colors.purple,
            value: (deliveryToCustomer ?? 0).toDouble(),
            title: '${deliveryToCustomer ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 6:
          return PieChartSectionData(
            color: Colors.purpleAccent,
            value: (deliveredNoCity ?? 0).toDouble(),
            title: '${deliveredNoCity ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 7:
          return PieChartSectionData(
            color: Colors.deepOrange,
            value: (city ?? 0).toDouble(),
            title: '${city ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 8:
          return PieChartSectionData(
            color: Colors.blueGrey,
            value: (delivered ?? 0).toDouble(),
            title: '${delivered ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 9:
          return PieChartSectionData(
            color: Colors.grey.shade500,
            value: (fail ?? 0).toDouble(),
            title: '${fail ?? 0}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  @override
  void onInit() async {
    super.onInit();
    viewOrders();
    orderStatus();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData) {
        viewOrders(isLoadMore: true);
      }
    });
    final prefs = myServices.sharedPreferences;
    prefs.setString("noti", "0");
    await prefs.reload();

    update();
 Get.find<HomeControllerImp>().resetNoti();
  }
}
