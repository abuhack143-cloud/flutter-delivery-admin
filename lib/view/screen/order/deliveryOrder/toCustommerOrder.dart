import 'package:admin/controller/order/deliveryOrder/toCustommerOrder_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/order/customCardOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ToCustommerOrder extends StatelessWidget {
  final String? selectedOrderId;
  const ToCustommerOrder({super.key, this.selectedOrderId});

  @override
  Widget build(BuildContext context) {
    Get.put(ToCustommerOrderControllerImp());
    return GetBuilder<ToCustommerOrderControllerImp>(builder: (controller) {
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
                      from: "deliveryToCustomer".tr,
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
                      color: Colors.purple,
                      price: "${"price".tr}: ${order.orderPrice}",
                      onTap: () {
                        Get.toNamed(AppRoute.detail, arguments: {
                          "order_detail": order.orderId.toString()
                        });
                      },
                      citybutton: 'Order_tracking'.tr,
                      city: () {
                        Get.toNamed(
                          AppRoute.trackDelivery,
                          arguments: {
                            'ownerid': order.ownerId.toString(),
                            'orderid': order.orderId.toString(),
                            'deliveryid': order.orderDelivery.toString(),
                          },
                        );
                      },
                      ifCity: true,
                      forButton: false,
                      button: 'Order_tracking'.tr,
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
