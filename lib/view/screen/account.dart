import 'package:admin/controller/home_controller.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/account/customAccount.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "account".tr,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.white,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              if (Get.find<HomeControllerImp>().role != "admin_other")
                CustomAccount(
                  icon: FontAwesomeIcons.userShield,
                  text: "admin".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.admin);
                  },
                ),
              CustomAccount(
                icon: FontAwesomeIcons.store, // Store Owner icon
                text: "store_owner".tr,
                onTap: () {
                  Get.toNamed(AppRoute.storeOwner);
                },
              ),
              if (Get.find<HomeControllerImp>().role != "admin_other")
                CustomAccount(
                  icon: FontAwesomeIcons.truck, // Delivery icon
                  text: "delivery".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.delivey);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
