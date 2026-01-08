import 'package:admin/controller/order/cityOrder/cityOrder_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customdialog.dart';
import 'package:admin/view/widget/order/customCardOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CityOrder extends StatelessWidget {
  final String? selectedOrderId;
  const CityOrder({super.key, this.selectedOrderId});

  @override
  Widget build(BuildContext context) {
    Get.put(CityOrderControllerImp());
    return GetBuilder<CityOrderControllerImp>(builder: (controller) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToSelectedOrder(selectedOrderId);
      });
      return Scaffold(
        appBar: AppBar(
          title: Text("order_city".tr),
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
                      from: order.orderStatus == 7
                          ? "order_status_city".tr
                          : order.orderStatus == 5
                              ? "order_status_deliveryToCustomer".tr
                              : order.orderStatus == 11
                                  ? "order_status_adminAccepted".tr
                                  : "",
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
                      color: order.orderStatus == 7
                          ? Colors.deepOrange
                          : order.orderStatus == 11
                              ? Appcolor.green
                              : order.orderStatus == 5
                                  ? Colors.purple
                                  : Appcolor.primary,
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
                              order.orderAdmin.toString(),
                              order.orderOwner.toString(),
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
                            controller.rejectOrders(
                              order.orderId.toString(),
                              order.orderStatus.toString(),
                              order.orderAdmin.toString(),
                            );
                            Navigator.of(context).pop();
                          },
                          () {
                            Navigator.of(context).pop();
                          },
                          Appcolor.primary,
                        );
                      },
                      forButton: order.orderAdminCity.toString() ==
                              controller.myServices.sharedPreferences
                                  .getString("id")
                                  .toString() &&
                          order.orderStatus == 7,
                      ifCity: order.orderStatus == 11 &&
                          order.adminId.toString() !=
                              controller.myServices.sharedPreferences
                                  .getString("id")
                                  .toString(),
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
                              "page": "city",
                            });
                          },
                        );
                      },
                      watting: order.orderStatus == 5,
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
