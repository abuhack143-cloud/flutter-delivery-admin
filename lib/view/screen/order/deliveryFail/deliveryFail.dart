import 'package:admin/controller/order/deliveryFail/deliveryFail_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customdialog.dart';
import 'package:admin/view/widget/order/customCardOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DeliveryFail extends StatelessWidget {
  const DeliveryFail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryFailControllerImp());
    return GetBuilder<DeliveryFailControllerImp>(builder: (controller) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToSelectedOrder();
      });
      return Scaffold(
        appBar: AppBar(
          title: Text("delivery_fail".tr),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: RefreshIndicator(
          color: Appcolor.primary,
          onRefresh: () {
            return controller.viewOrders();
          },
          child: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.data.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.data.length) {
                  final order = controller.data[index];
                  bool isHighlighted =
                      order.orderId.toString() == controller.selectedOrderId;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: isHighlighted
                          ? controller.iscolor()
                          : Colors.transparent,
                    ),
                    child: CustomCardOrder(
                      from: "order_status_delivery_fail".tr,
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
                      color: Colors.redAccent.shade100,
                      price: "${"price".tr}: ${order.orderPrice}",
                      onTap: () {
                        Get.toNamed(AppRoute.detail, arguments: {
                          "order_detail": order.orderId.toString()
                        });
                      },
                      button: 'Accept'.tr,
                      forButton: false,
                      ifCity: true,
                      citybutton: order.orderStatus == 14
                          ? "choose_delivery".tr
                          : order.orderStatus == 15
                              ? "Waiting_delivery".tr
                              : order.orderStatus == 16
                                  ? "Order_tracking".tr
                                  : "",
                      citycolor: order.orderStatus == 14
                          ? Colors.blue
                          : order.orderStatus == 15
                              ? Colors.orange
                              : order.orderStatus == 16
                                  ? Colors.green
                                  : Appcolor.primary,
                      city: () {
                        if (order.orderStatus == 14) {
                          customDialog2(
                            "choose_option".tr,
                            "map".tr,
                            "manual".tr,
                            () {
                              controller.navigateToSecondPage(index);
                            },
                            () {
                              controller.navigateToDeliveryPage({
                                "ownerid": order.ownerId.toString(),
                                "orderid": order.orderId.toString(),
                                "orderNumber": order.orderNumber.toString(),
                                "page": "pending2",
                              });
                            },
                          );
                        }
                        if (order.orderStatus == 16) {
                          Get.toNamed(AppRoute.failtrackorder, arguments: {
                            "deliveryid": order.orderDelivery2.toString(),
                            "deliveryid3": order.orderDelivery3.toString(),
                          });
                        }
                      },
                      watting: false,
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
