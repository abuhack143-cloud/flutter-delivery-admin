import 'package:admin/controller/account/Image_controller.dart';
import 'package:admin/controller/account/storeowner/detailprofileOwner_controller.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/view/widget/customdialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/view/screen/settings/image.dart';
import 'package:admin/view/widget/settings/customTitleProfile.dart';

class DetailProfileOwner extends StatelessWidget {
  const DetailProfileOwner({super.key});
  Widget _tinyPlaceholder(String? tinyUrl) {
    if (tinyUrl == null || tinyUrl.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        color: Appcolor.primary,
      ));
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
    Get.lazyPut(() => DetailProfileOwnerControllerImp());
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
      body: GetBuilder<DetailProfileOwnerControllerImp>(
        builder: (controller) {
          var item = controller.data;

          if (item == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Appcolor.primary,
              ),
            );
          }

          return ListView(
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTitleProfile(
                        title: 'username'.tr, // "اسم المستخدم"
                        body: item.ownerName.toString(),
                      ),
                      CustomTitleProfile(
                        title: 'email'.tr, // "البريد الإلكتروني"
                        body: item.ownerEmail.toString(),
                      ),
                      CustomTitleProfile(
                        title:
                            'primary_phone_number'.tr, // "رقم الهاتف الرئيسي"
                        body: item.ownerPhone1.toString(),
                      ),
                      CustomTitleProfile(
                        title: 'secondary_phone_numbers'
                            .tr, // "أرقام الهاتف الثانوية"
                        body: item.ownerPhone2.toString(),
                      ),
                      CustomTitleProfile(
                        title: 'whatsapp'.tr, // "واتساب"
                        body: item.ownerWhatsApp.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Appcolor.grey,
                    thickness: 5,
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "personal_information".tr, // "المعلومات الشخصية"
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      )),
                  CustomTitleProfile(
                      title: "national_id".tr, // "الهوية الوطنية"
                      body: item.ownerNationalID!),
                  CustomTitleProfile(
                      title: "id_card_number".tr, // "رقم بطاقة الهوية"
                      body: item.ownerIDCardNumber!),
                  CustomTitleProfile(
                      title: "passport_number".tr, // "رقم جواز السفر"
                      body: item.ownerPassportNumber!),
                  Card(
                    child: Column(
                      children: [
                        const Divider(
                          color: Appcolor.primary,
                          indent: 20,
                          endIndent: 20,
                          thickness: 3,
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ImageViewerPage(
                                imageUrl:
                                    "${AppImageAsset.storeownerImage}${item.ownerPassportPic.toString()}",
                              ),
                              transition: Transition.cupertino,
                              gestureWidth: (context) =>
                                  MediaQuery.of(context).size.width * 1.2,
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: _chooseFullOrTiny(
                                item.ownerPassportPicSigned?.full ?? '',
                                item.ownerPassportPicSigned?.tiny ?? ''),
                            width: 310,
                            height: 200,
                            fit: BoxFit.cover,
                            cacheKey: item.ownerPassportPicSigned?.base,
                            placeholder: (context, url) => _tinyPlaceholder(
                                item.ownerPassportPicSigned?.tiny),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.myServices.sharedPreferences
                              .getString("role") !=
                          "admin_east" &&
                      controller.myServices.sharedPreferences
                              .getString("role") !=
                          "admin_west" &&
                      controller.myServices.sharedPreferences
                              .getString("role") !=
                          "admin_other")
                    GetBuilder<ImageControllerImp>(
                      builder: (controllerImg) {
                        return Column(
                          children: [
                            if (item.ownerApprove == 1)
                              Row(
                                children: [
                                  controllerImg.image.value == null
                                      ? Text('no_image_selected'.tr)
                                      : Image.file(
                                          controllerImg.image.value!,
                                          width: 40,
                                          height: 40,
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
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
                                if (item.ownerApprove == 1)
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            controllerImg.image.value == null
                                                ? Colors.grey
                                                : Colors.green),
                                        foregroundColor:
                                            const WidgetStatePropertyAll(
                                                Colors.white)),
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
                                        WidgetStatePropertyAll(Colors.red),
                                    foregroundColor:
                                        WidgetStatePropertyAll(Colors.white),
                                  ),
                                  onPressed: () {
                                    customDialog(
                                      "${"delete_warning".tr} ${item.ownerName}",
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
                                  child: Text(
                                    item.ownerApprove == 1
                                        ? 'reject'.tr
                                        : 'remove'.tr,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
