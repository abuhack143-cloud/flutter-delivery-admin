import 'package:admin/controller/account/admin/admin_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/view/screen/settings/image.dart';
import 'package:admin/view/widget/account/delivery/customRowInfo.dart';
import 'package:admin/view/widget/customdialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    AdminControllerImp controller = Get.put(AdminControllerImp());
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
              "admin".tr,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (controller.myServices.sharedPreferences.getString("role") !=
                    "admin_all" &&
                controller.myServices.sharedPreferences.getString("role") !=
                    "admin_east" &&
                controller.myServices.sharedPreferences.getString("role") !=
                    "admin_west" &&
                controller.myServices.sharedPreferences.getString("role") !=
                    "admin_other")
              GestureDetector(
                onTap: () {
                  controller.navigateToSecondPage();
                },
                child: Text(
                  "add".tr,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          color: Appcolor.primary,
          onRefresh: () async {
            await controller.refreshData();
            await Future.delayed(const Duration(seconds: 2));
          },
          child: Column(
            children: [
              if (controller.myServices.sharedPreferences.getString("role") !=
                  "admin_other")
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'all'.tr,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    items: controller.items,
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
              Expanded(
                child: GetBuilder<AdminControllerImp>(builder: (controller) {
                  return HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: ListView.builder(
                      cacheExtent: 1000,
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) {
                        final admin = controller.data[index];
                        return Card(
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    admin.adminRole == "superadmin"
                                        ? "superadmin".tr
                                        : admin.adminRole == "admin_pro"
                                            ? "admin_pro".tr
                                            : admin.adminRole == "admin_east"
                                                ? "admin_east".tr
                                                : admin.adminRole ==
                                                        "admin_west"
                                                    ? "admin_west".tr
                                                    : admin.adminRole ==
                                                            "admin_other"
                                                        ? "admin_other".tr
                                                        : admin.adminRole ==
                                                                "admin_all"
                                                            ? "admin_all".tr
                                                            : "",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => ImageViewerPage(
                                            // استخدم الرابط الموقّع إن وجد وإلا استخدم adminImage التقليدي
                                            imageUrl: admin
                                                    .adminImageSigned?.full ??
                                                "${AppImageAsset.adminImage}${admin.adminImage ?? ''}",
                                            imagekey:
                                                admin.adminImageSigned?.base ??
                                                    (admin.adminImage ?? ''),
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
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            // نفضّل استخدام full لعرض واضح، إن لم يتوفر نستخدم المسار التقليدي
                                            imageUrl: admin
                                                    .adminImageSigned?.full ??
                                                "${AppImageAsset.adminImage}${admin.adminImage ?? ''}",
                                            placeholder: (context, url) => admin
                                                        .adminImageSigned
                                                        ?.tiny !=
                                                    null
                                                ? Image.network(
                                                    admin.adminImageSigned!
                                                        .tiny!,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  )
                                                : Center(
                                                    child: Lottie.asset(
                                                        AppImageAsset.loading,
                                                        width: 50),
                                                  ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                            cacheKey:
                                                admin.adminImageSigned?.base ??
                                                    (admin.adminImage ?? ''),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomRowInfo(
                                            text1: "${"name".tr}: ",
                                            text2:
                                                admin.adminName?.toString() ??
                                                    "",
                                          ),
                                          CustomRowInfo(
                                            text1: "${"email".tr}: ",
                                            text2:
                                                admin.adminEmail?.toString() ??
                                                    "",
                                          ),
                                          CustomRowInfo(
                                            text1: "${"branch".tr}: ",
                                            text2:
                                                admin.adminBranch?.toString() ??
                                                    "",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                if ((controller.role == "superadmin" ||
                                        controller.role == "admin_pro") &&
                                    (admin.adminId.toString() !=
                                        controller.myServices.sharedPreferences
                                            .getString("id")) &&
                                    admin.adminId != 1)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        // child: GestureDetector(
                                        //   onTap: () {
                                        //     customDialog(
                                        //       "${"delete_warning".tr} ${admin.adminName}",
                                        //       "Delete".tr,
                                        //       "cancel".tr,
                                        //       () {
                                        //         controller.removeAdmin(
                                        //             admin.adminId.toString(),
                                        //             // تمرير مفتاح الصورة التقليدي إذا لم يكن هناك base
                                        //             admin.adminImageSigned?.base ??
                                        //                 admin.adminImage ??
                                        //                 "");
                                        //         Navigator.of(context).pop();
                                        //       },
                                        //       () {
                                        //         Navigator.of(context).pop();
                                        //       },
                                        //       Colors.red,
                                        //     );
                                        //   },
                                        // child: Text(
                                        //   "remove".tr,
                                        //   style: TextStyle(
                                        //       fontSize: MediaQuery.of(context)
                                        //               .size
                                        //               .width *
                                        //           0.05),
                                        // ),

                                        child: IconButton(
                                          icon: Container(
                                            width: 43,
                                            height: 43,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(13)),
                                            child: controller.isDelete ==
                                                        true &&
                                                    controller.id ==
                                                        admin.adminId.toString()
                                                ? CircularProgressIndicator(
                                                    color: Colors.white,
                                                    padding: EdgeInsets.all(12),
                                                  )
                                                : Icon(Icons.delete,
                                                    color: Colors.white),
                                          ),
                                          onPressed: controller.isDelete == true
                                              ? null
                                              : () {
                                                  customDialog(
                                                    "${"delete_warning".tr} ${admin.adminName}",
                                                    "Delete".tr,
                                                    "cancel".tr,
                                                    () {
                                                      controller.id = admin
                                                          .adminId
                                                          .toString();
                                                      controller.update();
                                                      controller.removeAdmin(
                                                          admin.adminId
                                                              .toString(),
                                                          // تمرير مفتاح الصورة التقليدي إذا لم يكن هناك base
                                                          admin.adminImageSigned
                                                                  ?.base ??
                                                              admin
                                                                  .adminImage ??
                                                              "");
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    Colors.red,
                                                  );
                                                },
                                        ),

                                        // ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
