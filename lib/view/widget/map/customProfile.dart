import 'package:admin/core/constant/route.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:admin/view/widget/customImageProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';

class CustomMapProfile extends StatelessWidget {
  final dynamic data1;
  final dynamic data2;
  final void Function()? onTap;
  const CustomMapProfile({super.key, this.data1, this.data2, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            CustomImageProfile(image:  "${data1.isNotEmpty ? data1[0].deliveryImageSigned!.full : data2.isNotEmpty ? data2[0].ownerProfileSigned!.full : ''}",
            imageKey: "${data1.isNotEmpty ? data1[0].deliveryImage : data2.isNotEmpty ? data2[0].ownerProfile : ''}",),
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
                    "${data1.isNotEmpty ? data1[0].deliveryName : data2.isNotEmpty ? data2[0].ownerName : ''}"),
                Text(
                    "${data1.isNotEmpty ? data1[0].deliveryPhone1 : data2.isNotEmpty ? data2[0].ownerPhone1 : ''}"),
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
                  "${data1.isNotEmpty ? data1[0].deliveryWhatsApp : data2.isNotEmpty ? data2[0].ownerWhatsApp : ''}"),
            ],
          ),
        ),
        CustomButton(
          text: "Detail".tr,
          minimumSize: const Size(100, 35),
          onTap: () {
            if (data1.isNotEmpty) {
              Get.toNamed(AppRoute.detaildelivey, arguments: {
                "id": data1.isNotEmpty
                    ? data1[0]
                    : '',
                "name": data1.isNotEmpty
                    ? data1[0].deliveryName
                    .toString()
                    : '',
                "data": data1.isNotEmpty
                    ? data1[0]
                    : '',
              });

            } else if (data2.isNotEmpty) {
              Get.toNamed(AppRoute.detailowner, arguments: {
                "id":  data2.isNotEmpty
                    ? data2[0].id.toString()
                    :'',
                "name": data2.isNotEmpty
                    ? data2[0].ownerName.toString()
                    : '',
                "data": data2.isNotEmpty
                    ? data2[0]
                    : '',
              });
            }
          },
        ),
        const Divider(),
        Center(
          child: CustomButton(
            text: "choose".tr,
            minimumSize: const Size(260, 45),
            backgroundColor: Appcolor.primary,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
