import 'package:admin/controller/order/pendingOrderCustommer/pending3Order_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/screen/order/qr.dart';
import 'package:admin/view/widget/order/customCardOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pending3OrderCustommer extends StatelessWidget {
  final String? selectedOrderId;
  const Pending3OrderCustommer({super.key, this.selectedOrderId});

  @override
  Widget build(BuildContext context) {
    Get.put(Pending3OrderCustommerControllerImp());
    return GetBuilder<Pending3OrderCustommerControllerImp>(
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
                      color: Colors.purple,
                      price: "${"price".tr}: ${order.orderPrice}",
                      admin: "${"admin".tr}: ${order.adminName.toString()}",
                      onTap: () {
                        Get.toNamed(AppRoute.detail, arguments: {
                          "order_detail": order.orderId.toString()
                        });
                      },
                      button: '',
                      onTap1: () {},
                      qr: "Order_QR".tr,
                      onTap2: () {
                        Get.to(() => OrderQRCode(
                              orderNumber: order.orderNumber.toString(),
                            ));
                      },
                      forButton: false,
                      reject: () {
                        controller.rejectOrders(
                          order.orderId.toString(),
                          order.orderStatus.toString(),
                          order.orderNumber.toString(),
                          order.deliveryId.toString(),
                        );
                      },
                    ),
                  );
                } else {
                  // مؤشر تحميل عند طلب بيانات جديدة
                  return controller.hasMoreData
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Appcolor.primary,
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
