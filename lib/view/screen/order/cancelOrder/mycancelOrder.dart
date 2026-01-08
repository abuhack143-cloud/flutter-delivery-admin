import 'package:admin/controller/order/cancelOrder/mycancelOrder_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';

import 'package:admin/view/widget/order/pending/customStatusCardOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MyCancelOrder extends StatelessWidget {
  const MyCancelOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyCancelOrderController());
    return GetBuilder<MyCancelOrderController>(builder: (controller) {
      return Scaffold(
        body: HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              if (index < controller.data.length) {
                final order = controller.data[index];
                return CustomStatusCardOrder(
                  from: "order_status_failed".tr,
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
                  color: Appcolor.brown,
                  price: "${"price".tr}: ${order.orderPrice}",
                  admin: "${"admin".tr}: ${order.adminName.toString()}",
                  delivery:
                      "${"Delivery".tr}: ${order.deliveryName.toString()}",
                  del: order.deliveryName != null,
                  onTap: () {
                    Get.toNamed(AppRoute.detail, arguments: {
                      "order_detail": order.orderId.toString(),
                      "location": true,
                    });
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
      );
    });
  }
}
