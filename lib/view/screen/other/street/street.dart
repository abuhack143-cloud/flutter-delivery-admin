import 'package:admin/controller/other/street/street_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/view/widget/account/admin/CustomDroplist.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Street extends StatelessWidget {
  const Street({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StreetControllerImp());
    return GetBuilder<StreetControllerImp>(builder: (controller) {
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
                "street".tr,
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
                      style: const TextStyle(fontSize: 19),
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
                CustomDroplist(
                  multi: true,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.selectAllFunction();
                      },
                      child: Text("select_All".tr),
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
                        controller: controller.scrollController,
                        itemCount: controller.dataStreet.length + 1,
                        itemBuilder: (context, index) {
                          if (index < controller.dataStreet.length) {
                            var data = controller.dataStreet[index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.checkBoxFunction(index);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: Text(
                                          data.streetName.toString(),
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (controller.checkbox.contains(
                                              data.streetId.toString()))
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .navigateEditPage(index);
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
                                            activeColor: Appcolor.primary,
                                            checkColor: Colors.white,
                                            value: controller
                                                .checkboxStates[index],
                                            onChanged: (value) {
                                              controller
                                                  .checkBoxFunction(index);
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
                          } else {
                            return controller.hasMoreData
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Lottie.asset(
                                        AppImageAsset.loading,
                                        width: 100,
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          }
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
                left: 50,
                right: 50,
                child: CustomButton(
                  backgroundColor: Colors.red,
                  onTap: () {
                    controller.deleteStreet();
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
