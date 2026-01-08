import 'package:admin/controller/account/delivery/delivery_controller.dart';
import 'package:admin/controller/home_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/view/screen/settings/image.dart';
import 'package:admin/view/widget/account/delivery/customRowInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryControllerImp());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Delivery".tr,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetBuilder<DeliveryControllerImp>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            color: Appcolor.primary,
            onRefresh: () async {
              await controller.refreshData();
            },
            child: Column(
              children: [
                if (Get.find<HomeControllerImp>().role != "admin_east" &&
                    Get.find<HomeControllerImp>().role != "admin_west" &&
                    Get.find<HomeControllerImp>().role != "admin_other")
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'not_accepted'.tr,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      items: [
                        {'key': '1', 'value': 'not_accepted'.tr},
                        {'key': '2', 'value': 'accepted'.tr},
                      ]
                          .map((item) => DropdownMenuItem<String>(
                                value: item['key'],
                                child: Text(item['value']!),
                              ))
                          .toList(),
                      value: controller.selectedValue,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedValue = value;
                          controller.getdata();
                          controller.update();
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Appcolor.primary,
                            width: 1,
                          ),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade900
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Expanded(
                    child: ListView.builder(
                      cacheExtent: 1000,
                      itemCount: controller.data.length + 1,
                      itemBuilder: (context, index) {
                        if (index < controller.data.length) {
                          final delivery = controller.data[index];

                          return Card(
                            shape: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // فتح الصورة الكاملة عند الضغط
                                          Get.to(
                                            () => ImageViewerPage(
                                              imageUrl: delivery
                                                      .deliveryImageSigned
                                                      ?.full ??
                                                  "",
                                              imagekey: delivery
                                                      .deliveryImageSigned
                                                      ?.base ??
                                                  "",
                                            ),
                                            transition: Transition.cupertino,
                                            gestureWidth: (context) =>
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1.2,
                                          );
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: CachedNetworkImage(
                                              imageUrl: delivery
                                                      .deliveryImageSigned
                                                      ?.full ??
                                                  "",
                                              placeholder: (context, url) =>
                                                  delivery.deliveryImageSigned
                                                              ?.tiny !=
                                                          null
                                                      ? Image.network(
                                                          delivery
                                                              .deliveryImageSigned!
                                                              .tiny!,
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                        )
                                                      : Center(
                                                          child: Lottie.asset(
                                                              AppImageAsset
                                                                  .loading,
                                                              width: 50),
                                                        ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              fit: BoxFit.cover,
                                              cacheKey: delivery
                                                      .deliveryImageSigned
                                                      ?.base ??
                                                  "",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.5,
                                          child: Column(
                                            children: [
                                              CustomRowInfo(
                                                text1: "Name".tr,
                                                text2: delivery.deliveryName
                                                        ?.toString() ??
                                                    "",
                                              ),
                                              CustomRowInfo(
                                                text1: "Phone1".tr,
                                                text2: delivery.deliveryPhone1
                                                        ?.toString() ??
                                                    "",
                                              ),
                                              CustomRowInfo(
                                                text1: "Phone2".tr,
                                                text2: delivery.deliveryPhone2
                                                        ?.toString() ??
                                                    "",
                                              ),
                                              CustomRowInfo(
                                                text1: "WhatsApp".tr,
                                                text2: delivery.deliveryWhatsApp
                                                        ?.toString() ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  if (delivery.deliveryApprove == 2)
                                    CustomRowInfo(
                                      text1: "Admin Approved".tr,
                                      text2: delivery.adminName.toString(),
                                    ),
                                  Row(
                                    children: [
                                      const Icon(Icons.more_horiz),
                                      GestureDetector(
                                        onTap: () {
                                          controller.navigateEditPage(index);
                                        },
                                        child: Text("Detail".tr),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return controller.hasMoreData
                              ? Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Lottie.asset(
                                      AppImageAsset.loading,
                                      width: 100,
                                    ),
                                  ))
                              : const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
