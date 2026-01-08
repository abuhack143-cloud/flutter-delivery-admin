import 'package:admin/controller/other/Packaging/Packaging_controller.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Packaging extends StatelessWidget {
  const Packaging({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PackagingControllerImp());
    return GetBuilder<PackagingControllerImp>(builder: (controller) {
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
                "Packaging".tr,
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
        body: ListView.builder(
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
                          "${"packaging".tr} : ${data.packagingPackaging}",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),
                      ),
                      Text(
                        "${"Price".tr} : ${data.packagingPrice}",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04),
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
                                "id": data.packagingId.toString(),
                                "packaging": data.packagingPackaging.toString(),
                                "price": data.packagingPrice.toString(),
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
                                  .deletePackaging(data.packagingId.toString());
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
      );
    });
  }
}
