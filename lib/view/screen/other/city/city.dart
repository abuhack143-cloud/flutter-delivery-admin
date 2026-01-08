import 'package:admin/controller/other/city/city_controller.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class City extends StatelessWidget {
  const City({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CityControllerImp());
    return GetBuilder<CityControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "City".tr,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  controller.navigateToSecondPage();
                },
                child: SizedBox(
                  width: 50,
                  height: 40,
                  child: Center(
                    child: Text(
                      "add".tr,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDroplist(
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
                            .toList();
                        controller.isClassError = false;
                        controller.cityData();
                        // تحديث واجهة المستخدم
                        controller.update();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (controller.statusRequest != StatusRequest.failure)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.selectAllFunction();
                        },
                        child: Text(controller.selectallText),
                      ),
                    ],
                  ),
                Expanded(
                  child: RefreshIndicator(
                    color: Appcolor.primary,
                    onRefresh: () {
                      return controller.refreshData();
                    },
                    child: HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: ListView.builder(
                        itemCount: controller.dataCity.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (!controller.checkbox.contains(controller
                                      .dataCity[index].cityId
                                      .toString())) {
                                    controller.checkbox.add(controller
                                        .dataCity[index].cityId
                                        .toString());
                                  }

                                  controller.toggleCheckbox(index);
                                  if (!controller.checkboxStates[index]) {
                                    controller.checkbox.remove(controller
                                        .dataCity[index].cityId
                                        .toString());
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${controller.dataCity[index].cityName.toString()} - ${controller.dataCity[index].cityPrice.toString()} (${controller.dataCity[index].classification.toString()})",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Row(
                                      children: [
                                        if (controller.checkbox.contains(
                                            controller.dataCity[index].cityId
                                                .toString()))
                                          InkWell(
                                            onTap: () {
                                              controller.navigateEditPage(
                                                {
                                                  "id": controller
                                                      .dataCity[index].cityId
                                                      .toString(),
                                                  "city": controller
                                                      .dataCity[index].cityName,
                                                  "price": controller
                                                      .dataCity[index].cityPrice
                                                      .toString(),
                                                  "plate": controller
                                                      .dataCity[index].cityPlate
                                                      .toString(),
                                                  "classification": controller
                                                      .dataCity[index]
                                                      .classification
                                                      .toString(),
                                                  "classificationId": controller
                                                      .dataCity[index]
                                                      .classificationId
                                                      .toString(),
                                                },
                                              );
                                            },
                                            child: SizedBox(
                                              width: 50,
                                              height: 40,
                                              child: Center(
                                                child: Text("Edit".tr),
                                              ),
                                            ),
                                          ),
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: Appcolor.primary,
                                          value:
                                              controller.checkboxStates[index],
                                          onChanged: (value) {
                                            if (!controller.checkbox.contains(
                                                controller
                                                    .dataCity[index].cityId
                                                    .toString())) {
                                              controller.checkbox.add(controller
                                                  .dataCity[index].cityId
                                                  .toString());
                                            }

                                            controller.toggleCheckbox(index);

                                            if (!controller
                                                .checkboxStates[index]) {
                                              controller.checkbox.remove(
                                                  controller
                                                      .dataCity[index].cityId
                                                      .toString());
                                            }
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (controller.checkboxStates.contains(true))
                  const SizedBox(
                    height: 55,
                  ),
              ],
            ),
            if (controller.checkboxStates.contains(true))
              Positioned(
                bottom: 10,
                right: 50,
                left: 50,
                child: CustomButton(
                  backgroundColor: Colors.red,
                  onTap: () {
                    controller.deleteData();
                  },
                  fontSize: MediaQuery.of(context).size.width * 0.047,
                  text: "Delete".tr,
                  minimumSize: const Size(270, 45),
                ),
              ),
          ],
        ),
      );
    });
  }
}
