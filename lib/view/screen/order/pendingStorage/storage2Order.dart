import 'package:admin/controller/order/storageOrder/storage2Order_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customdialog.dart';

import 'package:admin/view/widget/order/customCardOrder.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Storage2Order extends StatelessWidget {
  const Storage2Order({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Storage2OrderControllerImp());
    return GetBuilder<Storage2OrderControllerImp>(builder: (controller) {
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
              itemCount: controller.data.length,
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
                    admin: "${"admin".tr}: ${order.adminName.toString()}",
                    onTap: () {
                      Get.toNamed(AppRoute.detailStorage, arguments: {
                        "order_detail": order.storageId.toString()
                      });
                    },
                    button: 'Delivery'.tr,
                    color: Colors.green.shade700,
                    onTap1: () {
                      customDialog2(
                        "choose_option".tr,
                        "map".tr,
                        "manual".tr,
                        () {
                          controller.navigateToSecondPage({
                            "ownerid": order.ownerId.toString(),
                            "orderid": order.storageId.toString(),
                            "orderNumber": order.storageOrderNumber.toString(),
                          });
                        },
                        () {
                          controller.navigateToDeliveryPage({
                            "ownerid": order.ownerId.toString(),
                            "orderid": order.storageId.toString(),
                            "orderNumber": order.storageOrderNumber.toString(),
                            "page": "storage",
                          });
                        },
                      );
                    },
                    reject: () {
                      AwesomeDialog(
                        context: Get.context!,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        title: 'warining'.tr,
                        desc:
                            '${"Are you sure you want Reject order".tr} ${order.storageOrderNumber}',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          controller.rejectOrders(order.storageId.toString(),
                              order.storageStatus.toString());
                        },
                      ).show();
                    },
                  );
                } else {
                  // مؤشر تحميل عند طلب بيانات جديدة
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
