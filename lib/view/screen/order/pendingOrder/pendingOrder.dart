import 'package:admin/controller/order/pendingOrder/pendingOrder_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customdialog.dart';
import 'package:admin/view/widget/order/customCardOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PendingOrder extends StatelessWidget {
  final String? selectedOrderId;
  const PendingOrder({super.key, this.selectedOrderId});

  @override
  Widget build(BuildContext context) {
    Get.put(PendingOrderController());
    return GetBuilder<PendingOrderController>(builder: (controller) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToSelectedOrder(selectedOrderId);
      });
      return Scaffold(
        body: RefreshIndicator(
          color: Appcolor.primary,
          onRefresh: () {
            return controller.refreshData();
          },
          child: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller.scrollController,
              itemCount: controller.data.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.data.length) {
                  final order = controller.data[index];
                  bool isHighlighted =
                      order.orderId.toString() == selectedOrderId;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: isHighlighted
                          ? controller.iscolor()
                          : Colors.transparent,
                    ),
                    child: CustomCardOrder(
                      from: "order_status_not_accepted".tr,
                      orderNumber: "${'order_number'.tr}: ${order.orderNumber}",
                      dateJiffy: order.ordersDatetime!,
                      customerName:
                          '${'customer_name'.tr}: ${order.orderCustomerName}',
                      customerPhone:
                          '${'customer_phone'.tr}: ${order.orderCustomerPhone}',
                      customerLocation:
                          '${'customer_location'.tr}: ${order.addressCity ?? ""} - ${order.addressStreet ?? ""}',
                      orderPrice: '${'order_price'.tr}: ${order.orderPrice}',
                      orderDate: '${'order_date'.tr}: ${order.orderDate}',
                      color: Appcolor.red,
                      price: "${"price".tr}: ${order.orderPrice}",
                      onTap: () {
                        Get.toNamed(AppRoute.detail, arguments: {
                          "order_detail": order.orderId.toString()
                        });
                      },
                      button: 'Accept'.tr,
                      onTap1: () {
                        customDialog(
                          '${"Are_you_sure_you_want_Accept_order".tr} ${order.orderNumber}',
                          "ok".tr,
                          "cancel".tr,
                          () {
                            controller.approveOrders(
                              order.orderId.toString(),
                              order.ownerId.toString(),
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
                          '${"reject_order".tr} ${order.orderNumber}',
                          "ok".tr,
                          "cancel".tr,
                          () {
                            Navigator.of(context).pop();
                            controller.showCustomDialog(
                              context,
                              order.orderId.toString(),
                              order.orderStatus.toString(),
                            );
                          },
                          () {
                            Navigator.of(context).pop();
                          },
                          Appcolor.primary,
                        );
                      },
                    ),
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
