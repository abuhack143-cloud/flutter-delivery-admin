import 'package:admin/controller/order/StorageOrder/StorageOrder_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customdialog.dart';
import 'package:admin/view/widget/order/customCardOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class StorageOrder extends StatelessWidget {
  const StorageOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StorageOrderController());
    return GetBuilder<StorageOrderController>(builder: (controller) {
      return Scaffold(
        body: RefreshIndicator(
          color: Appcolor.primary,
          onRefresh: () {
            return controller.refreshData();
          },
          child: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.data.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.data.length) {
                  final order = controller.data[index];
                  return CustomCardOrder(
                    from: "storage".tr,
                    orderNumber:
                        '${"order_number".tr} : ${controller.data[index].storageOrderNumber}',
                    dateJiffy: controller.data[index].storageDate!,
                    customerName:
                        '${"shipment".tr} : ${controller.data[index].cate3Name}',
                    customerPhone:
                        '${"number".tr} : ${controller.data[index].storageNumber}',
                    customerLocation:
                        '${"location".tr} : ${controller.data[index].storageLocation}',
                    orderPrice:
                        '${"is_broken".tr} : ${controller.data[index].storageBroken}',
                    orderDate:
                        '${"is_fragile".tr} : ${controller.data[index].storageFragile}',
                    onTap: () {
                      Get.toNamed(AppRoute.detailStorage, arguments: {
                        "order_detail":
                            controller.data[index].storageId.toString()
                      });
                    },
                    color: Colors.red,
                    button: 'Accept'.tr,
                    onTap1: () {
                      customDialog(
                        '${"reject_order".tr} ${order.storageOrderNumber}',
                        "ok".tr,
                        "cancel".tr,
                        () {
                          controller.approveOrders(
                            order.storageId.toString(),
                            order.storageId.toString(),
                          );
                          Navigator.of(context).pop();
                        },
                        () {
                          Navigator.of(context).pop();
                        },
                        Appcolor.primary,
                      );
                    },
                    reject: () {
                      customDialog(
                        '${"reject_order".tr} ${order.storageOrderNumber}',
                        "ok".tr,
                        "cancel".tr,
                        () {
                          controller.showCustomDialog(
                            context,
                            order.storageId.toString(),
                            order.storageStatus.toString(),
                          );
                          Navigator.of(context).pop();
                        },
                        () {
                          Navigator.of(context).pop();
                        },
                        Appcolor.primary,
                      );
                    },
                  );
                } else {
                  return controller.hasMoreData
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Lottie.asset(
                              AppImageAsset.loading,
                              width: 100,
                            ),
                          ),
                        )
                      : const SizedBox();
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
