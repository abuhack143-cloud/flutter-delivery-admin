import 'package:admin/controller/other/collectionPoint/collectionPoint_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/link.dart';

class CollectionPoint extends StatelessWidget {
  const CollectionPoint({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CollectionPointControllerImp());
    return GetBuilder<CollectionPointControllerImp>(builder: (controller) {
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
                "collection_point".tr,
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
                var point = controller.data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade800
                            : Colors.white,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 70,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(point.cityName.toString()),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.access_time,
                                                size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(
                                              point.pointTime.toString(),
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.033,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                  height: 30, thickness: 1, color: Colors.grey),
                              Text(point.pointDetail.toString()),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Link(
                                  uri: Uri.parse(point.pointMaps.toString()),
                                  builder: (context, followLink) =>
                                      GestureDetector(
                                    onTap: followLink,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.map,
                                            color: Colors.blue),
                                        const SizedBox(width: 4),
                                        Text(
                                          "show_map".tr,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                  height: 30, thickness: 1, color: Colors.grey),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    text: "edit".tr,
                                    minimumSize: const Size(100, 40),
                                    backgroundColor: Appcolor.primary,
                                    onTap: () {
                                      controller.navigateEditPage({
                                        "id": point.pointId.toString(),
                                        "point": point.point.toString(),
                                        "pointCity": point.cityName.toString(),
                                        "pointDetail":
                                            point.pointDetail.toString(),
                                        "pointlocations":
                                            point.pointLocations.toString(),
                                        "pointTime": point.pointTime.toString(),
                                        "pointMaps": point.pointMaps.toString(),
                                      });
                                    },
                                    fontSize: 16,
                                  ),
                                  CustomButton(
                                    text: "Delete".tr,
                                    minimumSize: const Size(100, 40),
                                    backgroundColor: Colors.red,
                                    onTap: () {
                                      controller.deletePointData(
                                        point.pointId.toString(),
                                      );
                                    },
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
