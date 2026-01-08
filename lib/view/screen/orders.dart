import 'package:admin/controller/home_controller.dart';
import 'package:admin/controller/ordersPage_controller.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/account/customAccount.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersPageController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "order".tr, // الترجمة: "الطلبات"
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.white,
          child: GetBuilder<OrdersPageController>(builder: (controller) {
            return Column(
              children: [
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.clipboard,
                    text: "order_all".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.allorder);
                    },
                  ),
                CustomAccount(
                  icon: FontAwesomeIcons.listCheck,
                  text: "order_status".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.status);
                  },
                ),
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.clock,
                    text: "order_pending".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.mainpending);
                    },
                    showNoti: controller.notiCounts["pending"] != "0",
                    count: controller.notiCounts["pending"].toString(),
                  ),
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.hourglassHalf,
                    text: "order_pendingCustomer".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.mainpendingCustommer);
                    },
                    showNoti: controller.notiCounts["custommer"] != "0",
                    count: controller.notiCounts["custommer"].toString(),
                  ),
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.city,
                    text: "order_city".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.cityorder);
                    },
                    showNoti: controller.notiCounts["city"] != "0",
                    count: controller.notiCounts["city"].toString(),
                  ),
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.carBurst,
                    text: "delivery_fail".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.deliveryFail);
                    },
                    showNoti: controller.notiCounts["deliveryFail"] != "0",
                    count: controller.notiCounts["deliveryFail"].toString(),
                  ),
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.truckFast,
                    text: "order_delivery".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.mainDelivery);
                    },
                    showNoti: controller.notiCounts["delivering"] != "0",
                    count: controller.notiCounts["delivering"].toString(),
                  ),
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.boxOpen,
                    text: "order_delivered".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.maindelivered);
                    },
                    showNoti: controller.notiCounts["delivered"] != "0",
                    count: controller.notiCounts["delivered"].toString(),
                  ),
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.ban,
                    text: "order_canceled".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.maincancel);
                    },
                    showNoti: controller.notiCounts["maincancel"] != "0",
                    count: controller.notiCounts["maincancel"].toString(),
                  ),
                if (Get.find<HomeControllerImp>().role != "admin_other")
                  CustomAccount(
                    icon: FontAwesomeIcons.solidHdd,
                    text: "storage".tr,
                    onTap: () {
                      Get.toNamed(AppRoute.mainstorgae);
                    },
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
