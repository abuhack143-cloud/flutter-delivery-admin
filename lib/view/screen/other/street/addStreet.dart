import 'package:admin/controller/other/street/addStreet_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStreet extends StatelessWidget {
  const AddStreet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddStreetControllerImp());
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
            "AddStreet".tr,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<AddStreetControllerImp>(builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: controller.formstate,
                child: Column(
                  children: [
                    CustomDroplist(
                      multi: false,
                      selectedcolor: controller.selectcity.isNotEmpty,
                      errorcolor: controller.isCityError,
                      droptext: 'City'.tr,
                      data: controller.city,
                      text: 'City'.tr,
                      fornull: controller.selectcity.isNotEmpty,
                      selected: controller.selectcity.join(", "),
                      dropWWidth: MediaQuery.of(context).size.width * 0.83,
                      onSelected: (List<dynamic> selectedList) {
                        controller.cityOnSelect(selectedList);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Customtextformauth(
                      hintText: 'hint_Street'.tr,
                      labelText: 'Street'.tr,
                      iconData: Icons.location_city_outlined,
                      mycontroller: controller.streetName,
                      valid: (val) {
                        return validInput(val!, 1, 254, "Street");
                      },
                      type: TextInputType.text,
                    ),
                    Customtextformauth(
                      hintText: 'hint_StreetNumber'.tr,
                      labelText: 'StreetNumber'.tr,
                      iconData: Icons.format_list_numbered_sharp,
                      mycontroller: controller.streetNumber,
                      valid: (val) {
                        return validInput(val!, 1, 254, "StreetNumber");
                      },
                      type: TextInputType.text,
                    ),
                    Customtextformauth(
                      hintText: 'hint_price'.tr,
                      labelText: 'price'.tr,
                      iconData: Icons.price_change_outlined,
                      mycontroller: controller.price,
                      valid: (val) {
                        return validInput(val!, 0, 254, "price");
                      },
                      type: TextInputType.text,
                    ),
                    CustomButtonSubmit(
                      text: 'add'.tr,
                      onTap: () {
                        controller.addStreet();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
