import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:admin/controller/notification_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NotificationController());
    return GetBuilder<NotificationController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "notification".tr,
                ),
              ),
              body: HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        ...List.generate(
                            controller.data.length,
                            (index) => ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.data[index]
                                            ["notification_title"],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                          Jiffy.parse(
                                            controller.data[index]
                                                ["notification_date"],
                                          ).fromNow(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Appcolor.primary)),
                                    ],
                                  ),
                                  subtitle: Text(
                                    controller.data[index]["notification_body"],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
