import 'package:admin/controller/home_controller.dart';
import 'package:admin/controller/map_controller.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:admin/view/widget/customImageProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widget/map/customProfile.dart';

class MapSD extends StatelessWidget {
  const MapSD({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MapControllerImp());
    HomeControllerImp mapController = Get.find();
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
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
          "map".tr,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Appcolor.primary,
          ),
        ),
      ),
      body: GetBuilder<MapControllerImp>(builder: (controller) {
        if (controller.data1.isNotEmpty && controller.data2.isNotEmpty) {
          return CircularProgressIndicator(color: Appcolor.primary);
        }

        return Stack(
          children: [
            SizedBox(
              height: controller.info == true
                  ? MediaQuery.of(context).size.height * 0.79
                  : MediaQuery.of(context).size.height * 1,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: controller.markers.toSet(),
                onTap: (latlng) {
                  controller.info = false;
                  controller.data1.clear();
                  controller.data2.clear();
                  controller.update();
                },
                initialCameraPosition: mapController.kGooglePlex,
                onMapCreated: (GoogleMapController controllermap) {
                  // controller.completercontroller!.complete(controllermap);
                  if (!mapController.mapController.isCompleted) {
                    mapController.mapController.complete(controllermap);
                  }
                },
              ),
            ),
            if (controller.info == true &&
                (controller.data1.isNotEmpty || controller.data2.isNotEmpty))
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: CustomMapProfile(data1: controller.data1,
                      data2: controller.data2,
                      ),
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Center(
                      //       child: Icon(
                      //         Icons.horizontal_rule,
                      //         size: 45,
                      //         color: Appcolor.grey,
                      //       ),
                      //     ),
                      //     Row(
                      //       children: [
                      //         CustomImageProfile(
                      //           image:
                      //               "${controller.data1.isNotEmpty ? controller.data1[0].deliveryImageSigned!.full : controller.data2.isNotEmpty ? controller.data2[0].ownerProfileSigned!.full : ''}",
                      //         ),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Column(
                      //             children: [
                      //               Text("Name".tr),
                      //               Text("${"phone".tr}:"),
                      //             ],
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Column(
                      //             children: [
                      //               Text(
                      //                   "${controller.data1.isNotEmpty ? controller.data1[0].deliveryName : controller.data2.isNotEmpty ? controller.data2[0].ownerName : ''}"),
                      //               Text(
                      //                   "${controller.data1.isNotEmpty ? controller.data1[0].deliveryPhone1 : controller.data2.isNotEmpty ? controller.data2[0].ownerPhone1 : ''}"),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     const SizedBox(
                      //       height: 20,
                      //     ),
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width / 1.4,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         children: [
                      //           Text("${"whatsapp".tr}:"),
                      //           Text(
                      //               "${controller.data1.isNotEmpty ? controller.data1[0].deliveryWhatsApp : controller.data2.isNotEmpty ? controller.data2[0].ownerWhatsApp : ''}"),
                      //         ],
                      //       ),
                      //     ),
                      //     CustomButton(
                      //       text: "Detail".tr,
                      //       minimumSize: const Size(100, 35),
                      //       onTap: () {
                      //         if (controller.data1.isNotEmpty) {
                      //           Get.toNamed(AppRoute.detaildelivey, arguments: {
                      //             "id": controller.id.toString(),
                      //             "name": controller.data1.isNotEmpty
                      //                 ? controller.data1[0].deliveryName
                      //                     .toString()
                      //                 : '',
                      //             "data": controller.data1.isNotEmpty
                      //                 ? controller.data1[0]
                      //                 : '',
                      //           });
                      //
                      //           print(controller.data1[0]);
                      //         } else if (controller.data2.isNotEmpty) {
                      //           Get.toNamed(AppRoute.detailowner, arguments: {
                      //             "id": controller.id.toString(),
                      //             "name": controller.data2.isNotEmpty
                      //                 ? controller.data2[0].ownerName.toString()
                      //                 : '',
                      //             "data": controller.data2.isNotEmpty
                      //                 ? controller.data2[0]
                      //                 : '',
                      //           });
                      //         }
                      //       },
                      //     ),
                      //   ],
                      // ),
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
