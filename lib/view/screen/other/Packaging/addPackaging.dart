import 'package:admin/controller/other/packaging/addPackaging_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPackaging extends StatelessWidget {
  const AddPackaging({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddPackagingControllerImp());
    return GetBuilder<AddPackagingControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "add_packaging".tr,
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
                  text: "add".tr,
                  onTap: () => controller.addData(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
