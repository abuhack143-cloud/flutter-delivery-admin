import 'package:admin/controller/other/city/addCity_controller.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCity extends StatelessWidget {
  const AddCity({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddCityControllerImp());
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
            "AddCity".tr,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<AddCityControllerImp>(builder: (controller) {
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
                      droptext: 'classification'.tr,
                      data: controller.classification,
                      text: 'classification'.tr,
                      fornull: controller.selectcity.isNotEmpty,
                      selected: controller.selectcity.join(", "),
                      dropWWidth: MediaQuery.of(context).size.width * 0.83,
                      onSelected: (List<dynamic> selectedList) {
                        controller.classfunction(selectedList);
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
                        return validInput(val!, 1, 254, "plate");
                      },
                      type: TextInputType.text,
                    ),
                    Customtextformauth(
                      hintText: 'hint_price'.tr,
                      labelText: 'price'.tr,
                      iconData: Icons.price_change_outlined,
                      mycontroller: controller.cityPrice,
                      valid: (val) {
                        return validInput(val!, 0, 254, "price");
                      },
                      type: TextInputType.text,
                    ),
                    CustomButtonSubmit(
                      text: 'add'.tr,
                      loading: controller.statusRequest == StatusRequest.loading
                          ? CircularProgressIndicator(
                              color: Appcolor.primary,
                            )
                          : null,
                      onTap: controller.statusRequest == StatusRequest.loading
                          ? null
                          : () {
                              controller.addcity();
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
