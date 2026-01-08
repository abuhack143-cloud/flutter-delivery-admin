import 'package:admin/controller/other/categories/cate2/editCategories2_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategories2 extends StatelessWidget {
  const EditCategories2({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditCategories2ControllerImp());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<EditCategories2ControllerImp>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              controller.theCate.toString(),
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
                    CustomDroplist(
                      multi: false,
                      selectedcolor: controller.listCate1.isNotEmpty,
                      errorcolor: controller.isClassError,
                      droptext: 'categories1'.tr,
                      data: controller.cate1,
                      text: 'categories1'.tr,
                      fornull: controller.listCate1.isNotEmpty,
                      selected: controller.listCate1.join(", "),
                      dropWWidth: MediaQuery.of(context).size.width * 0.83,
                      onSelected: (List<dynamic> selectedList) {
                        if (selectedList.isNotEmpty) {
                          controller.listCate1 = selectedList
                              .whereType<SelectedListItem>()
                              .map((item) => item.data.toString())
                              .toList();

                          controller.stringcate1 = selectedList
                              .whereType<SelectedListItem>()
                              .map((item) => item.value.toString())
                              .join("");

                          controller.isClassError = false;

                          // تحديث واجهة المستخدم
                          controller.update();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Customtextformauth(
                      hintText: 'hint_categories'.tr,
                      labelText: 'categories'.tr,
                      iconData: Icons.category,
                      mycontroller: controller.cateName,
                      valid: (val) {
                        return validInput(val!, 1, 254, "city");
                      },
                      type: TextInputType.text,
                    ),
                    CustomButtonSubmit(
                      text: 'Edit'.tr,
                      onTap: () {
                        controller.editCate();
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
