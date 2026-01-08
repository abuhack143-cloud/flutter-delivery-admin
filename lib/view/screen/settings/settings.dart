import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/controller/settings/setting_controller.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/localization/changelocal.dart';
import 'package:admin/view/screen/settings/image.dart';
import 'package:jiffy/jiffy.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    SettingControllerImp settingController = Get.put(SettingControllerImp());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  clipBehavior: Clip.none,
                  height: Get.width / 2.6,
                  color: Appcolor.primary,
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        onTap: () {
                          Get.toNamed(AppRoute.profile);
                        },
                        title: Text('profile'.tr),
                        trailing: const Icon(Icons.person_outlined),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<SettingControllerImp>(
                          builder: (controller) => ListTile(
                                title: Text("theme".tr),
                                trailing: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: const Text(
                                      'Select Item',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    items: [
                                      {'key': 'System', 'value': 'System'.tr},
                                      {'key': 'Dark', 'value': 'Dark'.tr},
                                      {'key': 'Light', 'value': 'Light'.tr},
                                    ]
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item['key'],
                                              child: Text(item['value']!),
                                            ))
                                        .toList(),
                                    value: controller.selectedValue,
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.selectedValue = value;
                                        controller.toggleTheme(
                                            controller.selectedValue!);
                                      }
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                          color: Appcolor.primary,
                                          width: 1,
                                        ),
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.grey.shade900
                                            : Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<SettingControllerImp>(
                          builder: (controller) => ListTile(
                                title: Text("lang".tr),
                                trailing: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: const Text(
                                      'Select Item',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    items: ['English', 'العربية']
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item),
                                            ))
                                        .toList(),
                                    value: controller.selectedLang,
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.selectedLang =
                                            value as String?;
                                        if (controller.selectedLang ==
                                            'العربية') {
                                          Get.updateLocale(const Locale('ar'));
                                          LocalController controllerl =
                                              Get.put(LocalController());
                                          controllerl.changeLang("ar");
                                          controller
                                              .myServices.sharedPreferences
                                              .setString("langt", "العربية");
                                          Jiffy.setLocale("ar");
                                          controllerl.update();
                                        } else {
                                          Get.updateLocale(const Locale('en'));
                                          LocalController controllerl =
                                              Get.put(LocalController());
                                          controllerl.changeLang("en");
                                          controller
                                              .myServices.sharedPreferences
                                              .setString("langt", "English");
                                          Jiffy.setLocale("en");
                                          controllerl.update();
                                        }
                                      }
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                          color: Appcolor.primary,
                                          width: 1, // عرض الحدود
                                        ),
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.grey.shade900
                                            : Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text('contact_us'.tr), // ترجم النص
                        trailing: const Icon(Icons.phone_callback_outlined),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        onTap: () {
                          settingController.logout();
                        },
                        title: Text('log_out'.tr), // ترجم النص
                        trailing: const Icon(Icons.exit_to_app),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: Get.width / 3,
              left: (MediaQuery.of(context).size.width - 90) / 2,
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => ImageViewerPage(
                      imageUrl:
                          "${AppImageAsset.adminImage}${settingController.myServices.sharedPreferences.getString('image')}",
                    ),
                    transition: Transition.cupertino,
                    gestureWidth: (context) =>
                        MediaQuery.of(context).size.width * 1.2,
                  );
                },
                child: Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                    backgroundImage: settingController
                                .myServices.sharedPreferences
                                .getString('image') !=
                            null
                        ? NetworkImage(
                            "${AppImageAsset.adminImage}${settingController.myServices.sharedPreferences.getString('image') ?? ''}")
                        : const AssetImage("images/admin.png"),
                  ),
                ),
              ),
            ),
            Positioned(
              child: AppBar(
                backgroundColor: Colors.transparent,
                shape:
                    const Border(bottom: BorderSide(color: Colors.transparent)),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
