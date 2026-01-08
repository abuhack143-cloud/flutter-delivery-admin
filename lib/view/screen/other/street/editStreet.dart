import 'package:admin/controller/other/street/editStreet_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStreet extends StatelessWidget {
  const EditStreet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditStreetControllerImp());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<EditStreetControllerImp>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              controller.street.toString(),
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          body: HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
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
                          if (selectedList.isNotEmpty) {
                            controller.selectcity = selectedList
                                .whereType<SelectedListItem>()
                                .map((item) => item.data.toString())
                                .toList();

                            controller.selectedCity = selectedList
                                .whereType<SelectedListItem>()
                                .map((item) => item.value.toString())
                                .join(", ");
                            controller.isCityError = false;

                            // تحديث واجهة المستخدم
                            controller.update();
                          }
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
                          return validInput(val!, 6, 254, "StreetNumber");
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
                        text: 'Edit'.tr,
                        onTap: () {
                          controller.editStreet();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
