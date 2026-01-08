import 'package:admin/controller/other/boxSize/editBoxSize_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBoxSize extends StatelessWidget {
  const EditBoxSize({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditBoxSizeControllerImp());
    return GetBuilder<EditBoxSizeControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            controller.theSize.toString(),
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Customtextformauth(
                  hintText: 'hint_size'.tr,
                  labelText: 'size'.tr,
                  iconData: Icons.local_shipping,
                  mycontroller: controller.size,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_width'.tr,
                  labelText: 'width'.tr,
                  iconData: Icons.aspect_ratio,
                  mycontroller: controller.width,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_length'.tr,
                  labelText: 'length'.tr,
                  iconData: Icons.straighten,
                  mycontroller: controller.length,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_height'.tr,
                  labelText: 'height'.tr,
                  iconData: Icons.height,
                  mycontroller: controller.height,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_weight'.tr,
                  labelText: 'weight'.tr,
                  iconData: Icons.scale,
                  mycontroller: controller.weight,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_price'.tr,
                  labelText: 'price'.tr,
                  iconData: Icons.price_change_outlined,
                  mycontroller: controller.price,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.number,
                ),
                CustomButtonSubmit(
                  text: "Edit".tr,
                  onTap: () {
                    controller.editBoxSizeData();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
