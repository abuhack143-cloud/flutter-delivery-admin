import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:admin/core/constant/color.dart';

class CustomCardOrder extends StatelessWidget {
  final Color color;
  final String from;
  final String orderNumber;
  final String dateJiffy;
  final String customerName;
  final String customerPhone;
  final String customerLocation;
  final String orderPrice;
  final String orderDate;
  final String? admin;
  final String? qr;
  final String button;
  final String? citybutton;
  final Color? citycolor;
  final String? rejectbutton;
  final Color? rejectcolor;

  final void Function()? onTap;
  final void Function()? onTap1;
  final void Function()? onTap2;
  final void Function()? reject;
  final void Function()? city;
  final bool forButton;
  final bool ifCity;
  final bool watting;
  final String? price;

  const CustomCardOrder({
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
    this.admin,
    required this.button,
    this.onTap1,
    this.qr,
    this.onTap2,
    this.forButton = true,
    this.reject,
    this.city,
    this.ifCity = false,
    this.watting = false,
    this.citybutton,
    this.rejectbutton,
    this.citycolor,
    this.rejectcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.white,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white38
                : Colors.black,
          ),
        ),
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
                  Text(Jiffy.parse(dateJiffy).fromNow()),
                ],
              ),
              const Divider(),
              Text(customerName),
              Text(customerPhone),
              Text(customerLocation),
              Text(orderPrice),
              Text(orderDate),
              if (admin != null) Text(admin!),
              if (qr != null)
                GestureDetector(
                  onTap: onTap2,
                  child: Text(
                    qr!,
                    style: const TextStyle(color: Appcolor.blue, fontSize: 20),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    const Icon(Icons.more_horiz),
                    Text(
                      'Detail'.tr,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 30,
              ),
              if (!watting)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!ifCity)
                      CustomButton(
                        onTap: reject,
                        minimumSize: const Size(90, 40),
                        text: rejectbutton ?? 'reject'.tr,
                        backgroundColor: rejectcolor ?? Colors.red,
                      ),
                    if (ifCity)
                      CustomButton(
                        onTap: city,
                        minimumSize: const Size(90, 40),
                        text: citybutton ?? "City".tr,
                        backgroundColor: citycolor ?? Colors.blue,
                      ),
                    if (forButton)
                      CustomButton(
                        onTap: onTap1,
                        minimumSize: const Size(90, 40),
                        text: button,
                        backgroundColor: Appcolor.primary,
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
