import 'package:admin/controller/other/packaging/editPackaging_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPackaging extends StatelessWidget {
  const EditPackaging({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditPackagingControllerImp());
    return GetBuilder<EditPackagingControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "edit_packaging".tr,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Customtextformauth(
                  hintText: 'hint_packaging'.tr,
                  labelText: 'packaging'.tr,
                  iconData: Icons.local_shipping,
                  mycontroller: controller.packaging,
                  valid: (val) => validInput(val!, 6, 254, "packaging"),
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_price'.tr,
                  labelText: 'price'.tr,
                  iconData: Icons.price_change_outlined,
                  mycontroller: controller.price,
                  valid: (val) => validInput(val!, 6, 254, "price"),
                  type: TextInputType.number,
                ),
                CustomButtonSubmit(
                  text: "Edit".tr,
                  onTap: () => controller.editData(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
