import 'package:admin/controller/order/StorageOrder/Storage3Order_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';

import 'package:admin/view/widget/order/customCardOrder.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Storage3Order extends StatelessWidget {
  const Storage3Order({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Storage3OrderControllerImp());
    return GetBuilder<Storage3OrderControllerImp>(builder: (controller) {
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
                    button: '',
                    onTap1: () {},
                    color: Colors.blue.shade700,
                    forButton: false,
                    citybutton: 'waiting'.tr,
                    ifCity: order.storageStatus == 3,
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
                          controller.rejectOrders(
                            order.storageId.toString(),
                            order.storageStatus.toString(),
                          );
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
