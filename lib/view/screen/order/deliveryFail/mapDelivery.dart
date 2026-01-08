import 'package:admin/controller/home_controller.dart';
import 'package:admin/controller/order/deliveryFail/mapDelivery_controller.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/screen/image.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDeliveryFail extends StatelessWidget {
  const MapDeliveryFail({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImp mapController = Get.find();

    Get.put(MapDeliveryFailControllerImp());
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
      body: GetBuilder<MapDeliveryFailControllerImp>(builder: (controller) {
        if (controller.data1.isEmpty) {
          return CircularProgressIndicator(
            color: Appcolor.primary,
          );
        }
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
            if (controller.info == true)
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
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => ImageViewerPage(
                                    imageKey: controller.data1[0].deliveryImage
                                        .toString(),
                                    imageUrl:
                                        "${controller.data1[0].deliveryImageSigned!.full}",
                                  ),
                                  transition: Transition.cupertino,
                                  gestureWidth: (context) =>
                                      MediaQuery.of(context).size.width * 1.2,
                                );
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                child: CircleAvatar(
                                    radius: 45,
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black
                                            : Colors.white,
                                    backgroundImage: NetworkImage(
                                        "${AppImageAsset.deleviryImage}${controller.data1.isNotEmpty ? controller.data1[0].deliveryImage : ''}")),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text("Name".tr),
                                Text("Phone".tr),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                    "${controller.data1.isNotEmpty ? controller.data1[0].deliveryName : ''}"),
                                Text(
                                    "${controller.data1.isNotEmpty ? controller.data1[0].deliveryPhone1 : ''}"),
                              ],
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
                        if (controller.data1.isNotEmpty)
                          if (controller.deliveryfail !=
                              controller.data1[0].deliveryId.toString())
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
