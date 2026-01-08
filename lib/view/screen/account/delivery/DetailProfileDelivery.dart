import 'package:admin/controller/account/Image_controller.dart';
import 'package:admin/controller/account/delivery/detailprofileDelivery_controller.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/view/widget/customdialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/constant/color.dart';

import 'package:admin/view/screen/settings/image.dart';
import 'package:admin/view/widget/settings/customTitleProfile.dart';

class DetailProfileDelivery extends StatelessWidget {
  const DetailProfileDelivery({super.key});

  Widget _tinyPlaceholder(String? tinyUrl) {
    if (tinyUrl == null || tinyUrl.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Image.network(
        tinyUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        // quick fallback in case tiny also errors: let CachedNetworkImage errorWidget handle it
      );
    }
  }

  String _chooseFullOrTiny(String? full, String? tiny) {
    if (full != null && full.isNotEmpty) return full;
    if (tiny != null && tiny.isNotEmpty) return tiny;
    return "";
  }

  @override
  Widget build(BuildContext context) {
    Get.put(DetailProfileControllerImp());
    Get.lazyPut(() => ImageControllerImp());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'profile'.tr,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<DetailProfileControllerImp>(
        builder: (controller) {
          final item = controller.data;
          if (item == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Appcolor.primary,
              ),
            );
          }
          final frontSigned = item.frontDrivingLicenseSigned;
          final backSigned = item.backDrivingLicenseSigned;
          final carManualSigned = item.carManualSigned;
          final technicalSigned = item.technicalInspectionSigned;
          final checkCarSigned = item.deliveryCheckCarPicSigned;
          return ListView(children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitleProfile(
                      title: 'username'.tr,
                      body: item.deliveryName.toString(),
                    ),
                    CustomTitleProfile(
                      title: 'email'.tr,
                      body: item.deliveryEmail.toString(),
                    ),
                    CustomTitleProfile(
                      title: 'primary_phone_number'.tr,
                      body: item.deliveryPhone1.toString(),
                    ),
                    CustomTitleProfile(
                      title: 'secondary_phone_numbers'.tr,
                      body: item.deliveryPhone2.toString(),
                    ),
                    CustomTitleProfile(
                      title: 'whatsapp'.tr,
                      body: item.deliveryWhatsApp.toString(),
                    ),
                  ],
                ),

                // Licenses card (front / back)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final url =
                                frontSigned?.full ?? frontSigned?.tiny ?? "";
                            if (url.isNotEmpty) {
                              Get.to(() => ImageViewerPage(
                                    imageUrl: url,
                                    imagekey:
                                        item.frontDrivingLicenseSigned!.base,
                                  ));
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: CachedNetworkImage(
                                imageUrl: _chooseFullOrTiny(
                                    frontSigned?.full, frontSigned?.tiny),
                                // if both empty, CachedNetworkImage will call errorWidget
                                placeholder: (context, url) =>
                                    _tinyPlaceholder(frontSigned?.tiny),
                                cacheKey: item.frontDrivingLicenseSigned!.base,
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Appcolor.primary,
                          indent: 20,
                          endIndent: 20,
                          thickness: 3,
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            final url =
                                backSigned?.full ?? backSigned?.tiny ?? "";
                            if (url.isNotEmpty) {
                              Get.to(() => ImageViewerPage(
                                    imageUrl: url,
                                    imagekey:
                                        item.backDrivingLicenseSigned!.base,
                                  ));
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: CachedNetworkImage(
                                imageUrl: _chooseFullOrTiny(
                                    backSigned?.full, backSigned?.tiny),
                                placeholder: (context, url) =>
                                    _tinyPlaceholder(backSigned?.tiny),
                                cacheKey: item.backDrivingLicenseSigned!.base,
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(color: Appcolor.grey, thickness: 5, height: 10),

                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'car_information'.tr,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),

                CustomTitleProfile(
                  title: 'driving_licence'.tr,
                  body: item.deliveryDrivingLicenceNumber.toString(),
                ),
                CustomTitleProfile(
                  title: 'license_plate_number'.tr,
                  body: item.licensePlateNumber.toString(),
                ),
                CustomTitleProfile(
                  title: 'insurance_expiry_date'.tr,
                  body: item.checkCar.toString(),
                ),

                // carManual / technicalInspection / deliveryCheckCarPic
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final url = carManualSigned?.full ??
                                carManualSigned?.tiny ??
                                "";
                            if (url.isNotEmpty) {
                              Get.to(() => ImageViewerPage(
                                    imageUrl: url,
                                    imagekey: item.carManualSigned!.base,
                                  ));
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: CachedNetworkImage(
                                imageUrl: _chooseFullOrTiny(
                                    carManualSigned?.full,
                                    carManualSigned?.tiny),
                                placeholder: (context, url) =>
                                    _tinyPlaceholder(carManualSigned?.tiny),
                                cacheKey: item.carManualSigned!.base,
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Appcolor.primary,
                          indent: 20,
                          endIndent: 20,
                          thickness: 3,
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            final url = technicalSigned?.full ??
                                technicalSigned?.tiny ??
                                "";
                            if (url.isNotEmpty) {
                              Get.to(() => ImageViewerPage(
                                    imageUrl: url,
                                    imagekey:
                                        item.technicalInspectionSigned!.base,
                                  ));
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: CachedNetworkImage(
                                imageUrl: _chooseFullOrTiny(
                                    technicalSigned?.full,
                                    technicalSigned?.tiny),
                                placeholder: (context, url) =>
                                    _tinyPlaceholder(technicalSigned?.tiny),
                                cacheKey: item.technicalInspectionSigned!.base,
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Appcolor.primary,
                          indent: 20,
                          endIndent: 20,
                          thickness: 3,
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            final url = checkCarSigned?.full ??
                                checkCarSigned?.tiny ??
                                "";
                            if (url.isNotEmpty) {
                              Get.to(() => ImageViewerPage(
                                    imageUrl: url,
                                    imagekey:
                                        item.deliveryCheckCarPicSigned!.base,
                                  ));
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: CachedNetworkImage(
                                imageUrl: _chooseFullOrTiny(
                                    checkCarSigned?.full, checkCarSigned?.tiny),
                                placeholder: (context, url) =>
                                    _tinyPlaceholder(checkCarSigned?.tiny),
                                cacheKey: item.deliveryCheckCarPicSigned!.base,
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                GetBuilder<ImageControllerImp>(
                  builder: (controllerImg) {
                    return HandlingDataRequest(
                      statusRequest: controller.statusRequest,
                      widget: Column(
                        children: [
                          if (item.deliveryApprove == 1)
                            Row(
                              children: [
                                controllerImg.image.value == null
                                    ? Text('no_image_selected'.tr)
                                    : Image.file(
                                        controllerImg.image.value!,
                                        width: 40,
                                        height: 40,
                                      ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: controllerImg.getImage,
                                  child: Text(
                                    'Contract_Image'.tr,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (item.deliveryApprove == 1)
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      controllerImg.image.value == null
                                          ? Colors.grey
                                          : Colors.green,
                                    ),
                                    foregroundColor:
                                        const MaterialStatePropertyAll(
                                            Colors.white),
                                  ),
                                  onPressed: () {
                                    if (controllerImg.image.value != null) {
                                      controller.statusRequest =
                                          StatusRequest.loading;
                                      controller.update();
                                      controller.detailAccept();
                                    }
                                  },
                                  child: Text("Accept".tr),
                                ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                ),
                                onPressed: () {
                                  customDialog(
                                    "${"delete_warning".tr} ${item.deliveryName}",
                                    "ok".tr,
                                    "cancel".tr,
                                    () {
                                      controller.detailReject();
                                      Navigator.of(context).pop();
                                    },
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                    Appcolor.primary,
                                  );
                                },
                                child: Text(item.deliveryApprove == 1
                                    ? 'reject'.tr
                                    : 'remove'.tr),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ]);
        },
      ),
    );
  }
}
