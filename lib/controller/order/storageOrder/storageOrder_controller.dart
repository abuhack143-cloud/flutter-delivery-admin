import 'package:admin/data/datasource/remote/order/storage.dart';
import 'package:admin/data/model/storageordermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';

class StorageOrderController extends GetxController {
  List<StorageOrderModel> data = [];

  MyServices myServices = Get.find();

  StorageData storageData = StorageData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController reason;

  int currentPage = 0; // صفحة البداية
  int pageSize = 20; // حجم الصفحة
  bool hasMoreData = true; // هل هناك بيانات إضافية
  final ScrollController scrollController = ScrollController();

  Future<void> viewOrders({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      data.clear(); // تنظيف البيانات عند الطلب الأول
      currentPage = 0;
      hasMoreData = true;
    }

    if (!hasMoreData) return;

    var response = await storageData.getStorageOrder(currentPage, pageSize);

    statusRequest = StatusRequest.loading;
    update();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        var responseData = response['data'];

        if (responseData is List) {
          List<StorageOrderModel> newStreetData =
              responseData.map((e) => StorageOrderModel.fromJson(e)).toList();

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
    var response = await storageData.approveOrder(
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
    var response = await storageData.rejectOrder(
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
    var response = await storageData.reasonOrder(
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
          title: const Text("admin reject Reason"),
          content: Column(
            children: [
              CupertinoTextField(
                controller: reason,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.026,
                    color: Colors.red),
                placeholder: "Please enter the reason for reject...",
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text("ok"),
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
    super.onInit();
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }
}
