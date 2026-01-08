import 'package:admin/view/screen/settings/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/controller/settings/profile_controller.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/view/widget/settings/customTitleProfile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileControllerImp profileController = Get.put(ProfileControllerImp());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'profile'.tr, // Translated string for 'Profile'
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitleProfile(
                  title: 'username'.tr, // Translated string for 'Username'
                  body: profileController.username!,
                ),
                CustomTitleProfile(
                  title: 'email'.tr, // Translated string for 'Email'
                  body: profileController.email!,
                ),
                CustomTitleProfile(
                  title:
                      'role'.tr, // Translated string for 'Primary phone number'
                  body: profileController.role!,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ImageViewerPage(
                            imageUrl:
                                "${AppImageAsset.adminImage}${profileController.image!}",
                          ));
                    },
                    child: Image.network(
                      "${AppImageAsset.adminImage}${profileController.image!}",
                      width: 350,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
