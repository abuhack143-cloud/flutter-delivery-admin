import 'package:admin/controller/other/notification/delivery_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/account/delivery/customRowInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryNotification extends StatelessWidget {
  const DeliveryNotification({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryNotificationControllerImp());
    return GetBuilder<DeliveryNotificationControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Delivery".tr,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          color: Appcolor.primary,
          onRefresh: () async {
            await controller.refreshData();
          },
          child: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) {
                        var data = controller.data[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomRowInfo(
                                            text1: "${"name".tr}: ",
                                            text2: controller
                                                .data[index].deliveryName
                                                .toString(),
                                          ),
                                          CustomRowInfo(
                                            text1: "${"email".tr}: ",
                                            text2: controller
                                                .data[index].deliveryEmail
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                GestureDetector(
                                  onTap: () {
                                    Get.back(
                                        result: data.deliveryId.toString());
                                  },
                                  child: Text(
                                    "choose".tr,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.046),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
