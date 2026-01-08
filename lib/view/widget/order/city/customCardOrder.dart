import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:admin/core/constant/color.dart';

class CustomCardCityOrder extends StatelessWidget {
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

  final void Function()? onTap;
  final void Function()? onTap1;
  final void Function()? onTap2;
  final void Function()? reject;
  final void Function()? city;
  final bool forButton;
  final bool ifCity;
  final bool waitting;
  final String? price;

  const CustomCardCityOrder({
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
    this.waitting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
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
                    fontSize: MediaQuery.of(context).size.width * 0.053,
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
                      fontSize: MediaQuery.of(context).size.width * 0.040,
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
              Center(
                child: CustomButton(
                  onTap: onTap,
                  minimumSize: const Size(260, 45),
                  text: 'Detail',
                  // backgroundColor: Appcolor.primary,
                  fontSize: MediaQuery.of(context).size.width * 0.043,
                ),
              ),
              const Divider(
                height: 30,
              ),
              if (!waitting)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!ifCity)
                      CustomButton(
                        onTap: reject,
                        minimumSize: const Size(100, 45),
                        text: 'Reject',
                        backgroundColor: Colors.red,
                        fontSize: MediaQuery.of(context).size.width * 0.043,
                      ),
                    if (ifCity)
                      CustomButton(
                        onTap: city,
                        minimumSize: const Size(100, 45),
                        text: "Choose",
                        backgroundColor: Colors.blue,
                        fontSize: MediaQuery.of(context).size.width * 0.043,
                      ),
                    if (forButton)
                      CustomButton(
                        onTap: onTap1,
                        minimumSize: const Size(100, 45),
                        text: button,
                        backgroundColor: Colors.green,
                        fontSize: MediaQuery.of(context).size.width * 0.043,
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
