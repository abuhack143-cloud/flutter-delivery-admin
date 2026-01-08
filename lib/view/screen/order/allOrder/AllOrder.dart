// ignore_for_file: unrelated_type_equality_checks

import 'package:admin/controller/order/allOrder/AllOrder_controller.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/view/widget/order/allOrder/pieChart.dart';
import 'package:admin/view/widget/order/allOrder/pieStatusColor.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/order/customCardOrder.dart';
import 'package:lottie/lottie.dart';

class AllOrder extends StatelessWidget {
  const AllOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AllOrderControllerImp());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("order_all".tr),
      ),
      body: GetBuilder<AllOrderControllerImp>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: RefreshIndicator(
            color: Appcolor.primary,
            onRefresh: () async {
              await controller.refreshData();
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  PieChartStatus(
                    sections: controller.showingSections(),
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        controller.touchedIndex = -1;
                      } else {
                        controller.touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      }
                      controller.pages();
                      controller.update();
                    },
                  ),
                  const PieStatusColor(),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.data.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.data.length) {
                        final order = controller.data[index];
                        return CustomCardOrder(
                          from: order.orderStatus == 0
                              ? "order_status_not_accepted".tr
                              : order.orderStatus == 1
                                  ? "order_status_accepted".tr
                                  : order.orderStatus == 2
                                      ? "order_status_DeliveryAccept".tr
                                      : order.orderStatus == 3
                                          ? "order_status_received".tr
                                          : order.orderStatus == 4
                                              ? "order_status_deliveryToAdmin"
                                                  .tr
                                              : order.orderStatus == 5 ||
                                                      order.orderStatus == 15
                                                  ? "order_status_deliveryToCustomer"
                                                      .tr
                                                  : order.orderStatus == 6 ||
                                                          order.orderStatus ==
                                                              16
                                                      ? "order_status_deliveredNoCity"
                                                          .tr
                                                      : order.orderStatus ==
                                                                  7 ||
                                                              order.orderStatus ==
                                                                  11
                                                          ? "order_status_city"
                                                              .tr
                                                          : order.orderStatus ==
                                                                  8
                                                              ? "order_status_delivered"
                                                                  .tr
                                                              : order.orderStatus ==
                                                                      9
                                                                  ? "order_status_failed"
                                                                      .tr
                                                                  : order.orderStatus ==
                                                                          14
                                                                      ? "order_status_delivery_fail"
                                                                          .tr
                                                                      : "",
                          orderNumber:
                              "${'order_number'.tr}: ${order.orderNumber}",
                          dateJiffy: order.ordersDatetime!,
                          customerName:
                              '${'customer_name'.tr}: ${order.orderCustomerName}',
                          customerPhone:
                              '${'customer_phone'.tr}: ${order.orderCustomerPhone}',
                          customerLocation:
                              '${'customer_location'.tr}: ${order.addressCity} - ${order.addressStreet}',
                          orderPrice:
                              '${'order_price'.tr}: ${order.orderPrice}',
                          orderDate: '${'order_date'.tr}: ${order.orderDate}',
                          color: order.orderStatus == 0
                              ? Appcolor.red
                              : order.orderStatus == 1
                                  ? Colors.green
                                  : order.orderStatus == 2
                                      ? Colors.blue.shade700
                                      : order.orderStatus == 3
                                          ? Appcolor.blue
                                          : order.orderStatus == 4
                                              ? Colors.teal
                                              : order.orderStatus == 5
                                                  ? Colors.purple
                                                  : order.orderStatus == 6
                                                      ? Colors.purpleAccent
                                                      : order.orderStatus ==
                                                                  7 ||
                                                              order.orderStatus ==
                                                                  11
                                                          ? Colors.amberAccent
                                                              .shade700
                                                          : order.orderStatus ==
                                                                  8
                                                              ? Colors.blueGrey
                                                              : order.orderStatus ==
                                                                      9
                                                                  ? Colors.grey
                                                                      .shade500
                                                                  : order.orderStatus ==
                                                                          14
                                                                      ? Colors
                                                                          .redAccent
                                                                          .shade100
                                                                      : Appcolor
                                                                          .primary,
                          onTap: () {
                            Get.toNamed(AppRoute.detail, arguments: {
                              "order_detail": order.orderId.toString()
                            });
                          },
                          button: '',
                          watting: true,
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
