import 'package:admin/controller/other/categories/cate3/categories3_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:admin/view/widget/other/customSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories3 extends StatelessWidget {
  const Categories3({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Categories3ControllerImp());
    return GetBuilder<Categories3ControllerImp>(builder: (controller) {
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.cate2.toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    controller.navigateToSecondPage(
                      {
                        "id": controller.id,
                      },
                    );
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
          body: HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Text(
                    "categories3".tr,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Customsearch(
                        onChanged: (value) {
                          controller.searchCate2Data(value);
                        },
                        mycontroller: controller.search,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (controller.selectAll) {
                              controller.selectAll = false;
                            } else {
                              controller.selectAll = true;
                            }
                            controller.update();

                            controller.selectAllCheckbox();
                          },
                          child: Text("select_All".tr),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) {
                        var data = controller.data[index];
                        return HandlingDataView(
                          statusRequest: controller.statusRequest,
                          widget: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (!controller.checkbox
                                      .contains(data.cate3Id.toString())) {
                                    controller.checkbox
                                        .add(data.cate3Id.toString());
                                  }

                                  controller.toggleCheckbox(index);
                                  if (!controller.checkboxStates[index]) {
                                    controller.checkbox
                                        .remove(data.cate3Id.toString());
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.53,
                                      child: Text(
                                        data.cate3Name.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        if (controller.checkbox
                                            .contains(data.cate3Id.toString()))
                                          InkWell(
                                            onTap: () {
                                              controller.navigateEditPage(
                                                {
                                                  "id": data.cate3Id.toString(),
                                                  "cate3": data.cate3Name,
                                                  "cate2": controller.cate2,
                                                  "cate1": controller.cate1,
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
                                                data.cate3Id.toString())) {
                                              controller.checkbox
                                                  .add(data.cate3Id.toString());
                                            }

                                            controller.toggleCheckbox(index);

                                            if (!controller
                                                .checkboxStates[index]) {
                                              controller.checkbox.remove(
                                                  data.cate3Id.toString());
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
                          ),
                        );
                      },
                    )),
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
          ),
        ),
      );
    });
  }
}
