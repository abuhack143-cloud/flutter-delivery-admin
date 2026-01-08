import 'package:admin/controller/other/report/report_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/view/screen/image.dart';
import 'package:admin/view/widget/account/delivery/customRowInfo.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportControllerImp());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "report".tr,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<ReportControllerImp>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.data.length + 1,
            itemBuilder: (context, index) {
              if (index < controller.data.length) {
                var data = controller.data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ImageViewerPage(
                                imageKey: controller.data[index].ownerProfile
                                    .toString(),
                                imageUrl:
                                    "${controller.data[index].ownerProfileSigned!.full}",
                              ),
                              transition: Transition.cupertino,
                              gestureWidth: (context) =>
                                  MediaQuery.of(context).size.width * 1.2,
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
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: controller
                                        .data[index].ownerProfileSigned!.full ??
                                    '',
                                placeholder: (context, url) => controller
                                            .data[index]
                                            .ownerProfileSigned
                                            ?.tiny !=
                                        null
                                    ? Image.network(
                                        controller.data[index]
                                                .ownerProfileSigned?.tiny ??
                                            '',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      )
                                    : Center(
                                        child: Lottie.asset(
                                            AppImageAsset.loading,
                                            width: 50),
                                      ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                cacheKey: controller
                                        .data[index].ownerProfileSigned?.base ??
                                    "",
                              ),
                            ),
                          ),
                        ),

                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(
                        //       () => ImageViewerPage(
                        //         imageUrl: "${data.ownerProfileSigned!.tiny}",
                        //       ),
                        //       transition: Transition.cupertino,
                        //       gestureWidth: (context) =>
                        //           MediaQuery.of(context).size.width * 1.2,
                        //     );
                        //   },
                        //   child: Container(
                        //     width: 80,
                        //     height: 80,
                        //     padding: const EdgeInsets.all(4),
                        //     decoration: BoxDecoration(
                        //       color: Theme.of(context).brightness ==
                        //               Brightness.dark
                        //           ? Colors.black
                        //           : Colors.white,
                        //       borderRadius: BorderRadius.circular(50),
                        //       border: Border.all(
                        //         color: Theme.of(context).brightness ==
                        //                 Brightness.dark
                        //             ? Colors.black
                        //             : Colors.white,
                        //       ),
                        //     ),
                        //     child: CircleAvatar(
                        //       radius: 45,
                        //       backgroundColor: Theme.of(context).brightness ==
                        //               Brightness.dark
                        //           ? Colors.black
                        //           : Colors.white,
                        //       backgroundImage: NetworkImage(
                        //           "${data.ownerProfileSigned!.tiny}"),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.height / 3.5,
                            child: Column(
                              children: [
                                CustomRowInfo(
                                  text1: "name".tr,
                                  text2: data.ownerName.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Text(
                          "the_report".tr,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          data.reportTheReport.toString(),
                        ),
                        const Divider(),
                        CustomButton(
                          text: "Delete".tr,
                          minimumSize: const Size(140, 45),
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          backgroundColor: Colors.red,
                          onTap: () {
                            controller.deleteButton(index);
                          },
                        )
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
                        ),
                      )
                    : const SizedBox();
              }
            },
          ),
        );
      }),
    );
  }
}
