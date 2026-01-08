import 'package:admin/controller/other/collectionPoint/addCollectionPoint_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCollectionPoint extends StatelessWidget {
  const AddCollectionPoint({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddCollectionPointControllerImp());
    return GetBuilder<AddCollectionPointControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "add_collection_point".tr,
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
                CustomDroplist(
                  multi: false,
                  selectedcolor: controller.selectcity.isNotEmpty,
                  errorcolor: controller.isCityError,
                  droptext: 'city'.tr,
                  data: controller.city,
                  text: 'city'.tr,
                  fornull: controller.selectcity.isNotEmpty,
                  selected: controller.selectcity,
                  dropWWidth: MediaQuery.of(context).size.width * 0.80,
                  onSelected: (List<dynamic> selectedList) {
                    if (selectedList.isNotEmpty) {
                      controller.selectcity = selectedList
                          .whereType<SelectedListItem>()
                          .map((item) => item.data)
                          .toString();

                      controller.valueCity = selectedList
                          .whereType<SelectedListItem>()
                          .map((item) => item.value.toString())
                          .toList();
                      controller.isCityError = false;

                      controller.update();
                    }
                  },
                ),
                const SizedBox(height: 20),
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
                  text: "add".tr,
                  onTap: () {
                    controller.addPointData();
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
