import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:admin/view/widget/order/customProfileDetail.dart';
import 'package:admin/view/widget/order/customTitleDetail.dart';
import 'package:admin/view/widget/order/storage/customDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/controller/order/detail_controller.dart';
import 'package:lottie/lottie.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailControllerImp());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Detail".tr),
      ),
      body: GetBuilder<DetailControllerImp>(
        builder: (controller) {
          if (controller.data.isEmpty) {
            return Center(
              child: Lottie.asset(
                AppImageAsset.loading,
                width: 120,
              ),
            );
          }

          var data = controller.data[0];

          return ListView(
            children: [
              CustomDetailCard(
                c1Text1: "item".tr,
                c1Text2: data.orderName.toString(),
                c2Text1: "count".tr,
                c2Text2: data.detailNumber.toString(),
                c3Text1: "price".tr,
                c3Text2: data.orderPrice.toString(),
              ),
              CustomDetailCard(
                c1Text1: "customer_name".tr,
                c1Text2: data.orderCustomerName.toString(),
                c2Text1: "customer_phone".tr,
                c2Text2: data.orderCustomerPhone.toString(),
                c3Text1: "order_day".tr,
                c3Text2: data.orderDay.toString(),
              ),
              CustomDetailCard(
                c1Text1: "".tr,
                c1Text2: "",
                c2Text1: "customer_address".tr,
                c2Text2: "${data.addressCity} - ${data.addressStreet}",
                c3Text1: "".tr,
                c3Text2: "",
              ),
              if (data.detailPackage != 0)
                CustomDetailCard(
                  c1Text1: "packaging".tr,
                  c1Text2: data.packagingPackaging.toString(),
                  c2Text1: "".tr,
                  c2Text2: "",
                  c3Text1: "package_price".tr,
                  c3Text2: data.packagingPrice.toString(),
                ),
              if (controller.location)
                Center(
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoute.cancellocation, arguments: {
                        "orderid": controller.orderDetail,
                        "deliveryid": data.deliveryId.toString(),
                      });
                    },
                    minimumSize: const Size(70, 35),
                    text: 'delivery_location'.tr,
                    backgroundColor: Appcolor.primary,
                    fontSize: 14,
                  ),
                ),

              // OWNER (store owner) - نفس النمط المطلوب
              if (data.ownerId != null)
                CustomProfileDetail(
                  ifImage: data.ownerProfile != null && data.ownerProfile != '',
                  imageError: "images/admin.png",
                  title: "store_owner".tr,
                  image: data.ownerProfileSigned?.full ?? '',
                  cache: data.ownerProfile,
                  placeholder: (context, url) => data
                              .ownerProfileSigned?.tiny !=
                          null
                      ? Image.network(
                          data.ownerProfileSigned!.tiny!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child: Lottie.asset(AppImageAsset.loading, width: 50),
                        ),
                  name: "${"Name".tr} ${data.ownerName}",
                  phone: "${"Phone1".tr} ${data.ownerPhone1}",
                  whatsApp: "${"WhatsApp".tr} ${data.ownerWhatsApp}",
                ),

              // ADMIN - طبق ما طلبت بالضبط تقريباً (مع null-safety بسيطة)
              if (data.adminId != null)
                CustomProfileDetail(
                  ifImage: data.adminImage != '',
                  imageError: "images/admin.png",
                  title: "admin".tr,
                  image: data.adminImageSigned?.full ?? '',
                  cache: data.adminImage,
                  placeholder: (context, url) => data.adminImageSigned?.tiny !=
                          null
                      ? Image.network(
                          data.adminImageSigned!.tiny!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child: Lottie.asset(AppImageAsset.loading, width: 50),
                        ),
                  name: "${"Name".tr} ${data.adminName}",
                  phone: "${"admin_role".tr}: ${data.adminRole}",
                  whatsApp: "",
                ),

              // DELIVERY (primary)
              if (data.deliveryId != null)
                CustomProfileDetail(
                  ifImage:
                      data.deliveryImage != null && data.deliveryImage != '',
                  imageError: "images/admin.png",
                  title: "Delivery".tr,
                  image: data.deliveryImageSigned?.full ?? '',
                  cache: data.deliveryImage,
                  placeholder: (context, url) => data
                              .deliveryImageSigned?.tiny !=
                          null
                      ? Image.network(
                          data.deliveryImageSigned!.tiny!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child: Lottie.asset(AppImageAsset.loading, width: 50),
                        ),
                  name: "${"Name".tr} ${data.deliveryName}",
                  phone: "${"Phone1".tr} ${data.deliveryPhone1}",
                  whatsApp: "${"WhatsApp".tr} ${data.deliveryWhatsApp}",
                ),

              // DELIVERY 2
              if (data.delivery2Id != null)
                CustomTitleDetail(
                  title: "order_status_deliveryToCustomer".tr,
                ),
              if (data.delivery2Id != null)
                CustomProfileDetail(
                  ifImage:
                      data.delivery2Image != null && data.delivery2Image != '',
                  imageError: "images/admin.png",
                  title: "${"Delivery".tr}2",
                  image: data.delivery2ImageSigned?.full ?? '',
                  cache: data.delivery2Image,
                  placeholder: (context, url) => data
                              .delivery2ImageSigned?.tiny !=
                          null
                      ? Image.network(
                          data.delivery2ImageSigned!.tiny!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child: Lottie.asset(AppImageAsset.loading, width: 50),
                        ),
                  name: "${"Name".tr} ${data.delivery2Name}",
                  phone: "${"Phone1".tr} ${data.delivery2Phone1}",
                  whatsApp: "${"WhatsApp".tr} ${data.delivery2WhatsApp}",
                ),

              // DELIVERY 3
              if (data.delivery3Id != null)
                CustomProfileDetail(
                  ifImage:
                      data.delivery3Image != null && data.delivery3Image != '',
                  imageError: "images/admin.png",
                  title: "${"Delivery".tr}3",
                  image: data.delivery3ImageSigned?.full ?? '',
                  cache: data.delivery3Image,
                  placeholder: (context, url) => data
                              .delivery3ImageSigned?.tiny !=
                          null
                      ? Image.network(
                          data.delivery3ImageSigned!.tiny!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child: Lottie.asset(AppImageAsset.loading, width: 50),
                        ),
                  name: "${"Name".tr} ${data.delivery3Name}",
                  phone: "${"Phone1".tr} ${data.delivery3Phone1}",
                  whatsApp: "${"WhatsApp".tr} ${data.delivery3WhatsApp}",
                ),

              // CITY ADMIN
              if (data.orderAdminCity.toString() != "0")
                CustomTitleDetail(
                  title: "adminCity".tr,
                ),
              if (data.orderAdminCity.toString() != "0")
                CustomProfileDetail(
                  ifImage:
                      data.cityAdminImage != null && data.cityAdminImage != '',
                  imageError: "images/admin.png",
                  title: "admin".tr,
                  image: data.cityAdminImageSigned?.full ?? '',
                  cache: data.cityAdminImage,
                  placeholder: (context, url) => data
                              .cityAdminImageSigned?.tiny !=
                          null
                      ? Image.network(
                          data.cityAdminImageSigned!.tiny!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child: Lottie.asset(AppImageAsset.loading, width: 50),
                        ),
                  name: "${"Name".tr} ${data.cityAdminName}",
                  phone: "${"admin_role".tr}: ${data.cityAdminRole}",
                  whatsApp: "",
                ),

              // REJECT SECTION
              if (data.reasonUser == "delivery" || data.reasonUser == "admin")
                CustomTitleDetail(
                  title: "reject".tr,
                ),
              if (data.reasonUser == "delivery")
                CustomProfileDetail(
                  ifImage: data.ownerProfile != null && data.ownerProfile != '',
                  imageError: "images/admin.png",
                  title: "Delivery".tr,
                  image: data.ownerProfileSigned?.full ?? '',
                  cache: data.ownerProfile,
                  placeholder: (context, url) => data
                              .ownerProfileSigned?.tiny !=
                          null
                      ? Image.network(
                          data.ownerProfileSigned!.tiny!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child: Lottie.asset(AppImageAsset.loading, width: 50),
                        ),
                  name: "${"Name".tr} ${data.deliveryName}",
                  phone: "${"reject".tr}: ${data.reasonTheReason}",
                  whatsApp: "",
                  color: Colors.red,
                ),
              if (data.reasonUser == "admin")
                CustomProfileDetail(
                  ifImage: data.adminImage != '',
                  imageError: "images/admin.png",
                  title: "Admin",
                  image: data.adminImageSigned?.full ?? '',
                  cache: data.adminImage,
                  placeholder: (context, url) => data.adminImageSigned?.tiny !=
                          null
                      ? Image.network(
                          data.adminImageSigned!.tiny!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child: Lottie.asset(AppImageAsset.loading, width: 50),
                        ),
                  name: "Name: ${data.adminName}",
                  phone: "Reject: ${data.reasonTheReason}",
                  whatsApp: "",
                  color: Colors.red,
                ),
            ],
          );
        },
      ),
    );
  }
}
