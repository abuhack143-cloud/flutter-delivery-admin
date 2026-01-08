import 'package:admin/controller/home_controller.dart';
import 'package:admin/controller/order/pendingOrder/mapDelivery_controller.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:admin/view/widget/customImageProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDelivery extends StatelessWidget {
  const MapDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImp mapController = Get.find();
    MapDeliveryControllerImp controllerImp =
        Get.put(MapDeliveryControllerImp());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.zero),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            controllerImp.socketService!.disconnect();
            controllerImp.update();
            Get.back();
          },
          color: Appcolor.primary,
        ),
        title: Text(
          "choose_delivery".tr,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Appcolor.primary,
          ),
        ),
      ),
      body: GetBuilder<MapDeliveryControllerImp>(builder: (controller) {
        return Stack(
          children: [
            SizedBox(
              height: controller.info == true
                  ? MediaQuery.of(context).size.height * 0.80
                  : MediaQuery.of(context).size.height * 1,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: controller.markers.toSet(),
                onTap: (latlng) {
                  controller.info = false;
                  controller.data1.clear();
                  controller.update();
                },
                initialCameraPosition: mapController.kGooglePlex,
                onMapCreated: (GoogleMapController controllermap) {
                  if (!mapController.mapController.isCompleted) {
                    mapController.mapController.complete(controllermap);
                  }
                },
              ),
            ),
            if (controller.info == true && controller.data1.isNotEmpty)
              DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.2,
                maxChildSize: 0.4,
                builder: (context, scrollController) => Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Icon(
                            Icons.horizontal_rule,
                            size: 45,
                            color: Appcolor.grey,
                          ),
                        ),
                        Row(
                          children: [
                            CustomImageProfile(
                              image:
                                  "${AppImageAsset.deleviryImage}${controller.data1.isNotEmpty ? controller.data1[0].deliveryImage : ''}",
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Name".tr),
                                  Text("phone".tr),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      "${controller.data1.isNotEmpty ? controller.data1[0].deliveryName : ''}"),
                                  Text(
                                      "${controller.data1.isNotEmpty ? controller.data1[0].deliveryPhone1 : ''}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("WhatsApp".tr),
                              Text(
                                  "${controller.data1.isNotEmpty ? controller.data1[0].deliveryWhatsApp : ''}"),
                            ],
                          ),
                        ),
                        CustomButton(
                          text: "Detail".tr,
                          minimumSize: const Size(100, 35),
                          onTap: () {
                            Get.toNamed(AppRoute.detaildelivey, arguments: {
                              "id": controller.data1[0].deliveryId.toString()
                            });
                          },
                        ),
                        const Divider(),
                        Center(
                          child: CustomButton(
                            text: "choose".tr,
                            minimumSize: const Size(260, 45),
                            backgroundColor: Appcolor.primary,
                            onTap: () {
                              controller.approveOrders(
                                controller.data1[0].deliveryId.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        );
      }),
    );
  }
}
