import 'package:admin/controller/home_controller.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/home/customcard.dart';
import 'package:admin/view/widget/home/customcardOrderNoti.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomGridView extends StatelessWidget {
  final bool admins;
  const CustomGridView({super.key, this.admins = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.78,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 25,
        ),
        children: [
          if (Get.find<HomeControllerImp>().role != "admin_other")
            CustomCard(
              icon: Icons.map,
              text: "maps".tr,
              onTap: () {
                Get.toNamed(AppRoute.mapSD);
              },
            ),
          CustomCardOrderNoti(
            icon: FontAwesomeIcons.list,
            text: "orders".tr,
            onTap: () {
              Get.toNamed(AppRoute.order);
            },
          ),
          CustomCard(
            icon: FontAwesomeIcons.user,
            text: "account".tr,
            onTap: () {
              Get.toNamed(AppRoute.account);
            },
          ),
          if (admins)
            CustomCard(
              icon: FontAwesomeIcons.layerGroup,
              text: "other".tr,
              onTap: () {
                Get.toNamed(AppRoute.other);
              },
            ),
          CustomCard(
            icon: Icons.settings,
            text: "settings".tr,
            onTap: () async {
              Get.toNamed(AppRoute.settings);
            },
          ),
        ],
      ),
    );
  }
}
