import 'package:admin/controller/other/notification/notification_controller.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:admin/view/widget/other/notification/customRowRadio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notification extends StatelessWidget {
  const Notification({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "send_notification".tr,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<NotificationController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'all'.tr,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    items: controller.items,
                    value: controller.selectedValue,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedValue = value;
                        controller.id = null;
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
                          color: controller.selectedValue == null
                              ? Appcolor.grey
                              : Appcolor.primary,
                          width: 1,
                        ),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade900
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.selectedValue != "All" &&
                  controller.selectedValue != null)
                CustomRowRadio(
                  radio1text: "special".tr,
                  radio2text: "all".tr,
                  titletext: "choose".tr,
                  groupValue: controller.group,
                  onChanged1: (value) {
                    controller.group = value as int;
                    controller.update();
                  },
                  onChanged2: (value) {
                    controller.group = value as int;
                    controller.update();
                  },
                  error: controller.isRadioError,
                  onTap1: () {
                    controller.group = 1;
                    controller.update();
                  },
                  onTap2: () {
                    controller.group = 2;
                    controller.update();
                  },
                ),
              if (controller.group == 1)
                Center(
                  child: CustomButton(
                    text: controller.id != null ? "choosed".tr : "choose".tr,
                    minimumSize: const Size(100, 35),
                    onTap: () {
                      controller.selcetnavigate();
                    },
                    backgroundColor:
                        controller.id != null ? Colors.green : Appcolor.grey,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    if (value != "") {
                      controller.titletf = true;
                    } else {
                      controller.titletf = false;
                    }

                    controller.update();
                  },
                  controller: controller.title,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "title".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: const BorderSide(color: Appcolor.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: const BorderSide(color: Appcolor.primary),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      if (value != "") {
                        controller.bodytf = true;
                      } else {
                        controller.bodytf = false;
                      }

                      controller.update();
                    },
                    controller: controller.body,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: "body".tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: const BorderSide(color: Appcolor.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: const BorderSide(color: Appcolor.primary),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: "send".tr,
                    minimumSize: const Size(335, 55),
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    backgroundColor: Appcolor.primary,
                    onTap: controller.button()
                        ? () {
                            FocusScope.of(context).unfocus();
                            controller.sendData();
                          }
                        : null,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
