import 'package:admin/view/widget/order/allOrder/customPieColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/constant/color.dart';

class PieStatusColor extends StatelessWidget {
  const PieStatusColor({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3, // تحسين التناسب بين العرض والارتفاع
        ),
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: [
          Indicator(
            color: Appcolor.red,
            text: 'not_accepted'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.green.shade700,
            text: 'accepted'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.blue,
            text: 'DeliveryAccept'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.teal,
            text: 'Received'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.teal,
            text: 'deliveryToAdmin'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.purple,
            text: 'deliveryToCustomer'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.purpleAccent,
            text: 'deliveredNoCity'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.amberAccent.shade700,
            text: 'City'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.blueGrey,
            text: 'Delivered'.tr,
            isSquare: true,
          ),
          Indicator(
            color: Colors.grey.shade500,
            text: 'Fail'.tr,
            isSquare: true,
          ),
        ],
      ),
    );
  }
}
