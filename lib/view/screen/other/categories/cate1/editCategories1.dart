import 'package:admin/controller/other/categories/cate1/editCategories1_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategories1 extends StatelessWidget {
  const EditCategories1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditCategories1ControllerImp());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<EditCategories1ControllerImp>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              controller.theCate1.toString(),
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: controller.formstate,
                child: Column(
                  children: [
                    Customtextformauth(
                      hintText: 'hint_categories'.tr,
                      labelText: 'categories'.tr,
                      iconData: Icons.category,
                      mycontroller: controller.cate1Name,
                      valid: (val) {
                        return validInput(val!, 1, 254, "city");
                      },
                      type: TextInputType.text,
                    ),
                    CustomButtonSubmit(
                      text: 'edit'.tr,
                      onTap: () {
                        controller.editCate1();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
