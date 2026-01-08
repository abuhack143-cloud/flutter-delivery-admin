import 'package:admin/controller/order/storageOrder/detailStorage_controller.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/view/widget/order/customProfileDetail.dart';
import 'package:admin/view/widget/order/storage/customDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DetailStorage extends StatelessWidget {
  const DetailStorage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DetailStorageControllerImp());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("detail".tr),
      ),
      body: GetBuilder<DetailStorageControllerImp>(
        builder: (controller) {
          if (controller.data.isEmpty) {
            return Center(
              child: Lottie.asset(
                AppImageAsset.noData,
                width: 300,
              ),
            );
          }

          var data = controller.data[0];

          return ListView(
            children: [
              CustomDetailCard(
                c1Text1: "Categories 1".tr,
                c1Text2: data.cate1Name.toString(),
                c2Text1: "Categories 2".tr,
                c2Text2: data.cate2Name.toString(),
                c3Text1: "Categories 3".tr,
                c3Text2: data.cate3Name.toString(),
              ),

              CustomDetailCard(
                c1Text1: "newOld".tr,
                c1Text2: data.storageNewOld.toString(),
                c2Text1: "Fragile".tr,
                c2Text2: data.storageFragile.toString(),
                c3Text1: "broken".tr,
                c3Text2: data.storageBroken.toString(),
              ),

              CustomDetailCard(
                c1Text1: "address".tr,
                c1Text2: data.storageLocation.toString(),
                c2Text1: "temperature".tr,
                c2Text2: data.storageTemperature.toString(),
                c3Text1: "lighSun".tr,
                c3Text2: data.storageLighSun.toString(),
              ),

              CustomDetailCard(
                c1Text1: "duration".tr,
                c1Text2: data.storageDuration.toString(),
                c2Text1: "conditions".tr,
                c2Text2: data.storageConditions.toString(),
                c3Text1: "cost".tr,
                c3Text2: data.storageCost.toString(),
              ),

              if (data.deliveryId != null)
                CustomProfileDetail(
                  ifImage: data.deliveryImage != null,
                  imageError: "images/admin.png",
                  title: "Delivery",
                  image: "${AppImageAsset.deleviryImage}${data.deliveryImage}",
                  name: "Name: ${data.deliveryName}",
                  phone: "Phone: ${data.deliveryPhone1}",
                  whatsApp: "WhatsApp: ${data.deliveryWhatsApp}",
                ),
              if (data.ownerId != null)
                CustomProfileDetail(
                  ifImage: data.ownerProfile != null || data.ownerProfile != '',
                  imageError: "images/admin.png",
                  title: "StoreOwner",
                  image: "${AppImageAsset.storeownerImage}${data.ownerProfile}",
                  name: "Name: ${data.ownerName}",
                  phone: "Phone: ${data.ownerPhone1}",
                  whatsApp: "WhatsApp: ${data.ownerWhatsApp}",
                ),
              if (data.adminId != null)
                CustomProfileDetail(
                  ifImage: data.adminImage != '',
                  imageError: "images/admin.png",
                  title: "Admin",
                  image: "${AppImageAsset.adminImage}${data.adminImage}",
                  name: "Name: ${data.adminName}",
                  phone: "AdminRole: ${data.adminRole}",
                  whatsApp: "",
                ),
              // if (data.reasonUser == "delivery" || data.reasonUser == "admin")
              //   Row(
              //     children: [
              //       const Expanded(
              //         child: Divider(
              //           height: 4,
              //           color: Colors.white,
              //           thickness: 5,
              //         ),
              //       ),
              //       Text(
              //         "Reject",
              //         style: TextStyle(
              //             fontSize: MediaQuery.of(context).size.width * 0.09),
              //       ),
              //       Expanded(
              //         child: Divider(
              //           height: 4,
              //           color: Theme.of(context).brightness == Brightness.dark
              //               ? Colors.white
              //               : Colors.black,
              //           thickness: 5,
              //         ),
              //       ),
              //     ],
              //   ),
              // if (data.reasonUser == "delivery")
              //   CustomProfileDetail(
              //     ifImage: data.ownerProfile != null,
              //     imageError: "images/admin.png",
              //     title: "Delivery",
              //     image: "${AppImageAsset.storeownerImage}${data.ownerProfile}",
              //     name: "Name: ${data.deliveryName}",
              //     phone: "Reject: ${data.reasonTheReason}",
              //     whatsApp: "",
              //     color: Colors.red,
              //   ),
              // if (data.reasonUser == "admin")
              //   CustomProfileDetail(
              //     ifImage: data.adminImage != '',
              //     imageError: "images/admin.png",
              //     title: "Admin",
              //     image: "${AppImageAsset.adminImage}${data.adminImage}",
              //     name: "Name: ${data.adminName}",
              //     phone: "Reject: ${data.reasonTheReason}",
              //     whatsApp: "",
              //     color: Colors.red,
              //   ),
            ],
          );
        },
      ),
    );
  }
}
