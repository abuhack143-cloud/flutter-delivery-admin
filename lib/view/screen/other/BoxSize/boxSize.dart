import 'package:admin/controller/other/boxSize/boxSize_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Boxsize extends StatelessWidget {
  const Boxsize({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BoxsizeControllerImp());
    return GetBuilder<BoxsizeControllerImp>(builder: (controller) {
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
                "Order_Size".tr,
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
        body: RefreshIndicator(
          color: Appcolor.primary,
          onRefresh: () {
            return controller.onRefresh();
          },
          child: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                var data = controller.data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "${"size".tr} : ${data.boxSize}",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
                          ),
                          Text(
                            "${"width".tr} : ${data.boxWidth}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          Text(
                            "${"Length".tr} : ${data.boxLength}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          Text(
                            "${"Height".tr} : ${data.boxHeight}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          Text(
                            "${"Weight".tr} : ${data.boxWeight}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          Text(
                            "${"Price".tr} : ${data.boxPrice}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                text: "Edit".tr,
                                minimumSize: const Size(100, 40),
                                backgroundColor: Appcolor.primary,
                                onTap: () {
                                  controller.navigateEditPage({
                                    "id": data.boxId.toString(),
                                    "size": data.boxSize,
                                    "width": data.boxWidth.toString(),
                                    "length": data.boxLength.toString(),
                                    "height": data.boxHeight.toString(),
                                    "weight": data.boxWeight.toString(),
                                    "price": data.boxPrice.toString(),
                                  });
                                },
                                fontSize: 16,
                              ),
                              CustomButton(
                                text: "Delete".tr,
                                minimumSize: const Size(100, 40),
                                backgroundColor: Colors.red,
                                onTap: () {
                                  controller
                                      .deleteBoxSizeData(data.boxId.toString());
                                },
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
