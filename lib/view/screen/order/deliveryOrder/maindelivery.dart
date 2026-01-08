import 'package:admin/controller/order/deliveryOrder/mainPending_controller.dart';
import 'package:admin/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDelivery extends StatelessWidget {
  const MainDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainDeliveryControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text("order_delivery".tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<MainDeliveryControllerImp>(
        builder: (controller) {
          return Row(
            children: [
              Expanded(
                child: DefaultTabController(
                  animationDuration: const Duration(milliseconds: 600),
                  length: controller.pages.length,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.17,
                        child: TabBar(
                          controller: controller.tabController,
                          tabs: controller.tabs,
                          labelColor: Appcolor.primary,
                          indicatorColor: Appcolor.primary,
                          unselectedLabelColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: controller.tabController,
                          children: controller.pages,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
