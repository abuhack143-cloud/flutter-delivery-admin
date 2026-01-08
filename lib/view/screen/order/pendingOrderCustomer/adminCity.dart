import 'package:admin/controller/order/pendingOrderCustommer/adminCity_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/account/delivery/customRowInfo.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCity extends StatelessWidget {
  const AdminCity({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminCityControllerImp());
    return GetBuilder<AdminCityControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "admin".tr,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              color: Appcolor.primary,
              onRefresh: () async {
                await controller.refreshData();
                await Future.delayed(const Duration(seconds: 2));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'all'.tr,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        items: [
                          {'key': '0', 'value': 'all'.tr},
                          {'key': 'superadmin', 'value': 'superadmin'.tr},
                          {'key': 'admin_pro', 'value': 'admin_pro'.tr},
                          {'key': 'admin_all', 'value': 'admin_all'.tr},
                          {'key': 'admin_east', 'value': 'admin_east'.tr},
                          {'key': 'admin_west', 'value': 'admin_west'.tr},
                          {'key': 'admin_other', 'value': 'admin_other'.tr},
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
                            controller.getdata();
                            controller.update();
                          }
                        },
                        buttonStyleData: ButtonStyleData(
                          width: double.infinity,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Appcolor.primary,
                              width: 1,
                            ),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...List.generate(
                      controller.data.length,
                      (index) {
                        var data = controller.data[index];
                        if (controller.myServices.sharedPreferences
                                .getString("id") ==
                            data.adminId.toString()) {
                          return const Text("");
                        }
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Center(
                                  child: Text(
                                    data.adminRole == "superadmin"
                                        ? "superadmin".tr
                                        : data.adminRole == "admin_pro"
                                            ? "admin_pro".tr
                                            : data.adminRole == "admin_east"
                                                ? "admin_east".tr
                                                : data.adminRole == "admin_west"
                                                    ? "admin_west".tr
                                                    : data.adminRole ==
                                                            "admin_other".tr
                                                        ? "Admin Other"
                                                        : "",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                const Divider(),
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
                                            text1: "Name".tr,
                                            text2: controller
                                                .data[index].adminName
                                                .toString(),
                                          ),
                                          CustomRowInfo(
                                            text1: "${"email".tr}: ",
                                            text2: controller
                                                .data[index].adminEmail
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                CustomButton(
                                  text: "choose".tr,
                                  minimumSize: const Size(100, 40),
                                  backgroundColor: Colors.green,
                                  onTap: () {
                                    AwesomeDialog(
                                      btnCancelText: "cancel".tr,
                                      btnOkText: 'ok'.tr,
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.rightSlide,
                                      title: "warning".tr,
                                      desc:
                                          "${"Are_You_Sure_you_Want_Choose".tr} ${data.adminName}",
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        controller.selectAdmin(
                                            data.adminId.toString());
                                      },
                                    ).show();
                                  },
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
