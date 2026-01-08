import 'package:admin/controller/order/acceptedOrder/acceptedOrder_controller.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/order/accepted/customCardHome.dart';
import 'package:admin/view/widget/other/customSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderStatusControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text("order_status".tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<OrderStatusControllerImp>(builder: (controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).unfocus();
        });
        return RefreshIndicator(
          color: Appcolor.primary,
          onRefresh: () {
            return controller.refreshData();
          },
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Card(
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.transparent
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade900
                        : Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 290,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 30,
                            childAspectRatio: 1,
                          ),
                          children: [
                            if (controller.statusRequest ==
                                StatusRequest.loading) ...[
                              ...List.generate(
                                10,
                                (index) {
                                  return Center(
                                    child: Lottie.asset(
                                      AppImageAsset.loading,
                                      width: 100,
                                    ),
                                  );
                                },
                              )
                            ] else ...[
                              CustomStatusHome(
                                title:
                                    '${controller.notApprovedCount ?? "No Data".tr}',
                                body: 'not_accepted'.tr,
                                color: Colors
                                    .red, // لون الأحمر للحالات غير المقبولة
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "not_accepted".tr,
                                    "value": "0"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title:
                                    '${controller.approvedCount ?? "No Data".tr}',
                                body: 'accepted'.tr,
                                color: Colors.green.shade700,
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "Accepted".tr,
                                    "value": "1"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title:
                                    '${controller.deliveryAccept ?? "No Data".tr}',
                                body: 'DeliveryAccept'.tr,
                                color: Colors.blue
                                    .shade700, // الأزرق الداكن للحالات التي تم قبولها للتوصيل
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "DeliveryAccept".tr,
                                    "value": "2"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title: '${controller.received ?? "No Data".tr}',
                                body: 'Received'.tr,
                                color:
                                    Colors.orange, // البرتقالي للحالات المستلمة
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "Received".tr,
                                    "value": "3"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title:
                                    '${controller.deliveryToAdmin ?? "No Data".tr}',
                                body: 'deliveryToAdmin'.tr,
                                color: Colors.teal,
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "deliveryToAdmin".tr,
                                    "value": "4"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title:
                                    '${controller.deliveryToCustomer ?? "No Data".tr}',
                                body: 'deliveryToCustomer'.tr,
                                color: Colors.purple,
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "deliveryToCustomer".tr,
                                    "value": "5"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title:
                                    '${controller.deliveredNoCity ?? "No Data".tr}',
                                body: 'deliveredNoCity'.tr,
                                color: Colors.purpleAccent,
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "deliveredNoCity".tr,
                                    "value": "6"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title: '${controller.city ?? "No Data".tr}',
                                body: 'City'.tr,
                                color: Colors.deepOrange,
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "City".tr,
                                    "value": "7"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title:
                                    '${controller.delivered ?? "No Data".tr}',
                                body: 'Delivered'.tr,
                                color: Colors.blueGrey,
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "Delivered".tr,
                                    "value": "8"
                                  });
                                },
                              ),
                              CustomStatusHome(
                                title: '${controller.fail ?? "No Data".tr}',
                                body: 'Fail'.tr,
                                color: Colors.grey.shade500,
                                onTap: () {
                                  Get.toNamed(AppRoute.search, arguments: {
                                    "status": controller.search,
                                    "title": "Fail".tr,
                                    "value": "9"
                                  });
                                },
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Customsearch(
                          mycontroller: controller.search,
                          onPressed: () {
                            Get.toNamed(AppRoute.search, arguments: {
                              "text": controller.search.text,
                              "title": "all".tr,
                              "value": "All"
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () {
                          Get.toNamed(AppRoute.qr);
                        },
                      ),
                    ],
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
