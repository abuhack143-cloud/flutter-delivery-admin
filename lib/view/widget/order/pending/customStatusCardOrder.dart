import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:admin/core/constant/color.dart';

class CustomStatusCardOrder extends StatelessWidget {
  final Color color;
  final String from;
  final String orderNumber;
  final String dateJiffy;
  final String customerName;
  final String customerPhone;
  final String customerLocation;
  final String orderPrice;
  final String orderDate;
  final String admin;
  final String delivery;
  final bool del;
  final void Function()? onTap;
  final void Function()? onTap2;
  final String? goTo;
  final String? price;

  const CustomStatusCardOrder({
    super.key,
    required this.from,
    required this.orderNumber,
    required this.dateJiffy,
    required this.customerName,
    required this.customerPhone,
    required this.customerLocation,
    required this.orderPrice,
    required this.orderDate,
    this.onTap,
    required this.color,
    this.price,
    required this.admin,
    required this.delivery,
    required this.del,
    this.goTo,
    this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  from,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: color,
                  ),
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    orderNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    Jiffy.parse(dateJiffy).fromNow(),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Text(customerName),
              Text(customerPhone),
              Text(customerLocation),
              Text(orderPrice),
              Text(orderDate),
              Text(admin),
              if (del) Text(delivery),
              const Divider(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onTap: onTap,
                    minimumSize: const Size(100, 45),
                    text: 'Detail'.tr,
                    backgroundColor: Appcolor.primary,
                    fontSize: 17,
                  ),
                  if (goTo != null)
                    InkWell(
                      onTap: onTap2,
                      child: Row(
                        children: [
                          Text(
                            goTo.toString(),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
