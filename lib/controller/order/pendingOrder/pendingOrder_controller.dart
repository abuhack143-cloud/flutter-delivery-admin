import 'package:admin/core/constant/color.dart';
import 'package:admin/data/datasource/remote/order/pending.dart';
import 'package:admin/data/model/storageordermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/model/OrderModel.dart';

class PendingOrderController extends GetxController {
  List<OrderModel> data = [];

  List<StorageOrderModel> data1 = [];

  MyServices myServices = Get.find();

  PendingData orderData = PendingData(Get.find());

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
      data.clear(); // تنظيف البيانات عند الطلب الأول
      currentPage = 0;
      hasMoreData = true;
    }

    if (!hasMoreData) return;

    var response = await orderData.getPendingOrder(currentPage, pageSize);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          List<OrderModel> newStreetData =
              responseData.map((e) => OrderModel.fromJson(e)).toList();

          if (newStreetData.length < pageSize) {
            hasMoreData = false; // لا توجد بيانات إضافية
          }

          data.addAll(newStreetData);

          currentPage += pageSize;
        }
      } else {
        hasMoreData = false;
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> approveOrders(String orderid, String storeOwnerid) async {
    var response = await orderData.approveOrder(
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

  Future<void> rejectOrders(String orderid, String status) async {
    var response = await orderData.rejectOrder(
      orderid,
      status,
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

  Future<void> reasonRejectOrder(String reason, String orderid) async {
    var response = await orderData.reasonOrder(
      reason,
      myServices.sharedPreferences.getString('id').toString(),
      orderid,
    );

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void showCustomDialog(
    BuildContext context,
    String orderid,
    String status,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("admin reject Reason".tr),
          content: Column(
            children: [
              CupertinoTextField(
                controller: reason,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.026,
                    color: Colors.red),
                placeholder: "Please_enter_the_reason_for_reject...".tr,
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                "cancel".tr,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                "ok".tr,
                style: TextStyle(color: Appcolor.primary),
              ),
              onPressed: () {
                reasonRejectOrder(reason.text, orderid);
                rejectOrders(orderid, status);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    // viewStorage();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData) {
        viewOrders(isLoadMore: true);
      }
    });
    orderData.crud.enableLogging();
    super.onInit();
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }
}
