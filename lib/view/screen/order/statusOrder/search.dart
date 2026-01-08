// ignore_for_file: unrelated_type_equality_checks

import 'package:admin/controller/order/acceptedOrder/search_controller.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/screen/order/cityOrder/cityOrder.dart';
import 'package:admin/view/widget/order/pending/customStatusCardOrder.dart';
import 'package:admin/view/widget/other/customSearch.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    SearchControllerImp controller = Get.put(SearchControllerImp());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("search".tr),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Customsearch(
                        mycontroller: controller.search,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.performSearch("");
                        }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        DropDownState(
                          dropDown: DropDown(
                            bottomSheetTitle: Text(
                              "status".tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            submitButtonChild: const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            data: controller.filter,
                            onSelected: (List<dynamic> selectedList) {
                              if (selectedList.isNotEmpty &&
                                  selectedList[0] is SelectedListItem) {
                                final selectedItem =
                                    selectedList[0] as SelectedListItem;
                                controller.selectedFilter = selectedItem.data;
                                controller.selectedItems =
                                    selectedItem.value.toString();

                                controller
                                    .getData(selectedItem.value.toString());
                              }
                            },
                            enableMultipleSelection: false,
                          ),
                        ).showModal(context);
                      },
                      child: GetBuilder<SearchControllerImp>(
                        builder: (controller) => Icon(
                          FontAwesomeIcons.filter,
                          color: controller.selectedFilter == "All".tr
                              ? Appcolor.grey
                              : Appcolor.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GetBuilder<SearchControllerImp>(
              builder: (controller) {
                return HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: controller.noResult
                      ? Expanded(
                          child: Center(
                            child: Text(
                              "No_Result".tr,
                              style: const TextStyle(
                                  fontSize: 20, color: Appcolor.primary),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: controller.data.length,
                            itemBuilder: (context, index) {
                              var order = controller.data[index];
                              return CustomStatusCardOrder(
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
                                                    : order.orderStatus == 5
                                                        ? "order_status_deliveryToCustomer"
                                                            .tr
                                                        : order.orderStatus == 6
                                                            ? "order_status_deliveredNoCity"
                                                                .tr
                                                            : order.orderStatus ==
                                                                    7
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
                                                                        : "",
                                orderNumber:
                                    "${'order_number'.tr}: ${order.orderNumber}",
                                dateJiffy: order.ordersDatetime!,
                                customerName:
                                    '${'customer_name'.tr}: ${order.orderCustomerName}',
                                customerPhone:
                                    '${'customer_phone'.tr}: ${order.orderCustomerPhone}',
                                customerLocation:
                                    '${'customer_location'.tr}: ${order.addressCity ?? ""} - ${order.addressStreet ?? ""}',
                                orderPrice:
                                    '${'order_price'.tr}: ${order.orderPrice}',
                                orderDate:
                                    '${'order_date'.tr}: ${order.orderDate}',
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
                                                            ? Colors
                                                                .purpleAccent
                                                            : order.orderStatus ==
                                                                        7 ||
                                                                    order.orderStatus ==
                                                                        11
                                                                ? Colors
                                                                    .amberAccent
                                                                    .shade700
                                                                : order.orderStatus ==
                                                                        8
                                                                    ? Colors
                                                                        .blueGrey
                                                                    : order.orderStatus ==
                                                                            9
                                                                        ? Colors
                                                                            .grey
                                                                            .shade500
                                                                        : order.orderStatus ==
                                                                                14
                                                                            ? Colors.redAccent.shade100
                                                                            : Appcolor.primary,
                                price: "${"price".tr}: ${order.orderPrice}",
                                admin: "Admin : ${order.adminName.toString()}",
                                delivery:
                                    "Delivery : ${order.deliveryName.toString()}",
                                del: order.deliveryName != null,
                                onTap: () {
                                  Get.toNamed(AppRoute.detail, arguments: {
                                    "order_detail": order.orderId.toString()
                                  });
                                },
                                goTo: "Go_To_Orders".tr,
                                onTap2: () {
                                  order.orderStatus == 0
                                      ? Get.toNamed(AppRoute.mainpending,
                                          arguments: {
                                              "orderId":
                                                  order.orderId.toString(),
                                              "targetTab": "0",
                                            })
                                      : order.orderStatus == 1
                                          ? Get.toNamed(AppRoute.mainpending,
                                              arguments: {
                                                  "orderId":
                                                      order.orderId.toString(),
                                                  "targetTab": "1",
                                                })
                                          : order.orderStatus == 2
                                              ? Get.toNamed(AppRoute.mainpending,
                                                  arguments: {
                                                      "orderId": order.orderId
                                                          .toString(),
                                                      "targetTab": "2",
                                                    })
                                              : order.orderStatus == 3
                                                  ? Get.toNamed(
                                                      AppRoute.mainDelivery,
                                                      arguments: {
                                                          "orderId": order
                                                              .orderId
                                                              .toString(),
                                                          "targetTab": "0",
                                                        })
                                                  : order.orderStatus == 6
                                                      ? Get.toNamed(
                                                          AppRoute.mainDelivery,
                                                          arguments: {
                                                              "orderId": order
                                                                  .orderId
                                                                  .toString(),
                                                              "targetTab": "1",
                                                            })
                                                      : order.orderStatus == 4
                                                          ? Get.toNamed(AppRoute.mainpendingCustommer,
                                                              arguments: {
                                                                  "orderId": order
                                                                      .orderId
                                                                      .toString(),
                                                                  "targetTab":
                                                                      "0",
                                                                })
                                                          : order.orderStatus ==
                                                                  5
                                                              ? Get.toNamed(AppRoute.mainpendingCustommer,
                                                                  arguments: {
                                                                      "orderId": order
                                                                          .orderId
                                                                          .toString(),
                                                                      "targetTab":
                                                                          "1",
                                                                    })
                                                              : order.orderStatus ==
                                                                      7
                                                                  ? Get.to(CityOrder(
                                                                      selectedOrderId: order
                                                                          .orderId
                                                                          .toString()))
                                                                  : order.orderStatus ==
                                                                          8
                                                                      ? Get.toNamed(
                                                                          AppRoute.maindelivered,
                                                                          arguments: {
                                                                              "orderId": order.orderId.toString(),
                                                                              "targetTab": "1",
                                                                            })
                                                                      : order.orderStatus == 9
                                                                          ? Get.toNamed(AppRoute.maincancel, arguments: {
                                                                              "orderId": order.orderId.toString(),
                                                                              "targetTab": "1",
                                                                            })
                                                                          : "";
                                },
                              );
                            },
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
