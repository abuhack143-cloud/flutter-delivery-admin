import 'package:admin/controller/order/pendingOrderCustommer/pending2Order_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/screen/order/qr.dart';
import 'package:admin/view/widget/customdialog.dart';
import 'package:admin/view/widget/order/customCardOrder.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Pending2OrderCustommer extends StatelessWidget {
  final String? selectedOrderId;
  const Pending2OrderCustommer({super.key, this.selectedOrderId});

  @override
  Widget build(BuildContext context) {
    Get.put(Pending2OrderCustommerControllerImp());
    return GetBuilder<Pending2OrderCustommerControllerImp>(
        builder: (controller) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToSelectedOrder(selectedOrderId);
      });
      return Scaffold(
        body: RefreshIndicator(
          color: Appcolor.primary,
          onRefresh: () {
            return controller.viewOrders();
          },
          child: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.data.length,
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
                      from: "order_status_deliveryToCustomer".tr,
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
                      color: Colors.teal,
                      price: "${"price".tr}: ${order.orderPrice}",
                      admin: "${"admin".tr}: ${order.adminName.toString()}",
                      onTap: () {
                        Get.toNamed(AppRoute.detail, arguments: {
                          "order_detail": order.orderId.toString()
                        });
                      },
                      button: 'Delivery'.tr,
                      onTap1: () {
                        controller.navigateToMap(
                          {
                            "orderid": order.orderId.toString(),
                            "ownerid": order.ownerId.toString(),
                          },
                        );
                      },
                      qr: "Order_QR".tr,
                      onTap2: () {
                        Get.to(() => OrderQRCode(
                              orderNumber: order.orderNumber.toString(),
                            ));
                      },
                      ifCity: true,
                      city: () {
                        customDialog2(
                          "choose_option".tr,
                          "map".tr,
                          "manual".tr,
                          () {
                            controller.navigateToSecondPage({
                              "ownerid": order.ownerId.toString(),
                              "orderid": order.orderId.toString(),
                              "orderNumber": order.orderNumber.toString(),
                            });
                          },
                          () {
                            controller.navigateToDeliveryPage({
                              "ownerid": order.ownerId.toString(),
                              "orderid": order.orderId.toString(),
                              "orderNumber": order.orderNumber.toString(),
                              "page": "pendingCustommer",
                            });
                          },
                        );
                      },
                    ),
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
