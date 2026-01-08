import 'package:admin/controller/other/collectionPoint/editCollectionPoint_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCollectionPoint extends StatelessWidget {
  const EditCollectionPoint({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditCollectionPointControllerImp());
    return GetBuilder<EditCollectionPointControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            controller.thePoint.toString(),
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Customtextformauth(
                  hintText: 'hint_point'.tr,
                  labelText: 'point'.tr,
                  iconData: Icons.location_on,
                  mycontroller: controller.point,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_pointCity'.tr,
                  labelText: 'pointCity'.tr,
                  iconData: Icons.location_city,
                  mycontroller: controller.pointCity,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_pointDetail'.tr,
                  labelText: 'pointDetail'.tr,
                  iconData: Icons.description,
                  mycontroller: controller.pointDetail,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_pointTime'.tr,
                  labelText: 'pointTime'.tr,
                  iconData: Icons.access_time,
                  mycontroller: controller.pointTime,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_pointlocations'.tr,
                  labelText: 'pointlocations'.tr,
                  iconData: Icons.map,
                  mycontroller: controller.pointlocations,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                Customtextformauth(
                  hintText: 'hint_pointMaps'.tr,
                  labelText: 'pointMaps'.tr,
                  iconData: Icons.map_outlined,
                  mycontroller: controller.pointMaps,
                  valid: (val) {
                    return validInput(val!, 6, 254, "price");
                  },
                  type: TextInputType.text,
                ),
                CustomButtonSubmit(
                  text: "Edit".tr,
                  onTap: () {
                    controller.editPointData();
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
