import 'package:admin/controller/other/categories/cate1/categories1_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:admin/view/widget/other/customSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories1 extends StatelessWidget {
  const Categories1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Categories1ControllerImp());
    return GetBuilder<Categories1ControllerImp>(builder: (controller) {
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
                  "categories".tr,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
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
          body: HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Text(
                    "categories1".tr,
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
                          controller.searchCate1Data(value);
                        },
                        mycontroller: controller.search,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectAll = !controller.selectAll;
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
                                        .contains(data.cate1Id.toString())) {
                                      controller.checkbox
                                          .add(data.cate1Id.toString());
                                    }
                                    controller.toggleCheckbox(index);
                                    if (!controller.checkboxStates[index]) {
                                      controller.checkbox
                                          .remove(data.cate1Id.toString());
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            AppRoute.cate2,
                                            arguments: {
                                              "id": data.cate1Id.toString(),
                                              "cate1": data.cate1Name,
                                            },
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.53,
                                              child: Text(
                                                data.cate1Name.toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (controller.checkbox.contains(
                                              data.cate1Id.toString()))
                                            InkWell(
                                              onTap: () {
                                                controller.navigateEditPage({
                                                  "id": data.cate1Id.toString(),
                                                  "cate1": data.cate1Name,
                                                });
                                              },
                                              child: SizedBox(
                                                width: 50,
                                                height: 40,
                                                child: Center(
                                                  child: Text("edit".tr),
                                                ),
                                              ),
                                            ),
                                          Checkbox(
                                            checkColor: Colors.white,
                                            activeColor: Appcolor.primary,
                                            value: controller
                                                .checkboxStates[index],
                                            onChanged: (value) {
                                              if (!controller.checkbox.contains(
                                                  data.cate1Id.toString())) {
                                                controller.checkbox.add(
                                                    data.cate1Id.toString());
                                              }
                                              controller.toggleCheckbox(index);
                                              if (!controller
                                                  .checkboxStates[index]) {
                                                controller.checkbox.remove(
                                                    data.cate1Id.toString());
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
                      ),
                    ),
                    if (controller.checkboxStates.contains(true))
                      const SizedBox(height: 55),
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
