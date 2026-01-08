import 'package:admin/controller/order/cancelOrder/mainCancel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/constant/color.dart';

class MainCancel extends StatelessWidget {
  const MainCancel({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainCancelControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text("order_canceled".tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<MainCancelControllerImp>(
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
                        child: TabBar(   controller: controller.tabController,
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
                        child: TabBarView(   controller: controller.tabController,
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
