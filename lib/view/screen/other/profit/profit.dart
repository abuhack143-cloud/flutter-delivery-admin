import 'package:admin/controller/other/profit/profit_controller.dart';
import 'package:admin/core/constant/imageasset.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Profit extends StatelessWidget {
  const Profit({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfitControllerImp());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("profit".tr),
      ),
      body: GetBuilder<ProfitControllerImp>(builder: (controller) {
        if (controller.data.isEmpty) {
          return Center(
            child: Lottie.asset(
              AppImageAsset.loading,
              width: 300,
            ),
          );
        }

        double? profit = double.tryParse(controller.data[0].profit.toString());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "delivery_worker_profit_percentage".tr,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ),
            Center(
              child: Text(
                "${(profit! * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Customtextformauth(
                hintText: 'hint_profit'.tr,
                labelText: 'profit'.tr,
                iconData: FontAwesomeIcons.sackDollar,
                mycontroller: controller.profitText,
                valid: (val) {
                  return validInput(val!, 0, 254, "price");
                },
                type: TextInputType.number,
              ),
            ),
            CustomButtonSubmit(
              text: "Edit".tr,
              onTap: () {
                controller.editProfit(controller.data[0].profitId.toString());
              },
            ),
          ],
        );
      }),
    );
  }
}
