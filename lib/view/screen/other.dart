// ignore_for_file: deprecated_member_use

import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/account/customAccount.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Other extends StatelessWidget {
  const Other({super.key});

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
            "other".tr,
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
            child: Column(
              children: [
                CustomAccount(
                  icon: Icons.location_city,
                  text: "city".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.city);
                  },
                ),
                CustomAccount(
                  icon: FontAwesomeIcons.road,
                  text: "street".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.street);
                  },
                ),
                CustomAccount(
                  icon: FontAwesomeIcons.boxOpen,
                  text: "box_size".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.boxsize);
                  },
                ),
                CustomAccount(
                  icon: FontAwesomeIcons.box,
                  text: "Packaging".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.packaging);
                  },
                ),
                CustomAccount(
                  icon: FontAwesomeIcons.layerGroup,
                  text: "categories".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.cate1);
                  },
                ),
                CustomAccount(
                  icon: FontAwesomeIcons.mapMarkerAlt,
                  text: "collection_point".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.collectionPoint);
                  },
                ),
                CustomAccount(
                  icon: FontAwesomeIcons.sackDollar,
                  text: "profit".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.profit);
                  },
                ),
                CustomAccount(
                  icon: FontAwesomeIcons.fileLines,
                  text: "terms_conditions".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.term);
                  },
                ),
                CustomAccount(
                  icon: FontAwesomeIcons.commentDots,
                  text: "report".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.report);
                  },
                ),
                CustomAccount(
                  icon: Icons.notifications_active,
                  text: "send_notification".tr,
                  onTap: () {
                    Get.toNamed(AppRoute.notification);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
