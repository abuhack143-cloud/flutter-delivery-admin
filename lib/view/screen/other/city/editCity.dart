import 'package:admin/controller/other/city/editCity_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCity extends StatelessWidget {
  const EditCity({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditCityControllerImp());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<EditCityControllerImp>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              controller.theCity.toString(),
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
                      selectedcolor: controller.listClasss.isNotEmpty,
                      errorcolor: controller.isClassError,
                      droptext: 'classification'.tr,
                      data: controller.classification,
                      text: 'classification'.tr,
                      fornull: controller.listClasss.isNotEmpty,
                      selected: controller.listClasss.join(", "),
                      dropWWidth: MediaQuery.of(context).size.width * 0.83,
                      onSelected: (List<dynamic> selectedList) {
                        if (selectedList.isNotEmpty) {
                          controller.listClasss = selectedList
                              .whereType<SelectedListItem>()
                              .map((item) => item.data.toString())
                              .toList();

                          controller.stringclass = selectedList
                              .whereType<SelectedListItem>()
                              .map((item) => item.value.toString())
                              .join(", ");
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
                      hintText: 'hint_city'.tr,
                      labelText: 'city'.tr,
                      iconData: Icons.location_city_outlined,
                      mycontroller: controller.cityName,
                      valid: (val) {
                        return validInput(val!, 1, 254, "city");
                      },
                      type: TextInputType.text,
                    ),
                    Customtextformauth(
                      hintText: 'hint_plate'.tr,
                      labelText: 'plate'.tr,
                      iconData: Icons.format_list_numbered_sharp,
                      mycontroller: controller.cityPlate,
                      valid: (val) {
                        return validInput(val!, 6, 254, "plate");
                      },
                      type: TextInputType.text,
                    ),
                    Customtextformauth(
                      hintText: 'hint_price'.tr,
                      labelText: 'price'.tr,
                      iconData: Icons.price_change_outlined,
                      mycontroller: controller.cityPrice,
                      valid: (val) {
                        return validInput(val!, 6, 254, "price");
                      },
                      type: TextInputType.text,
                    ),
                    CustomButtonSubmit(
                      text: 'Edit'.tr,
                      onTap: () {
                        controller.editCity();
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
