import 'package:admin/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCardOrderNoti extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color? color;
  final String? noti;
  final void Function()? onTap;
  const CustomCardOrderNoti({
    super.key,
    this.onTap,
    this.icon,
    required this.text,
    this.color,
    this.noti,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<HomeControllerImp>(builder: (controller) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Card(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black26
                          : Colors.grey.shade200,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: InkWell(
                        onTap: onTap,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            icon,
                            size: MediaQuery.of(context).size.width * 0.13,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    // Get.find<HomeControllerImp>()
                    //             .myServices
                    //             .sharedPreferences
                    //             .get("noti")
                    //             .toString() !=
                    //         "null"
                    //     ?
                    // الدائرة الحمراء الخاصة بالرقم
                    controller.notiCount != "0"
                        ? Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    controller.notiCount,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                                // إخفاء الدائرة لو العدد صفر
                                ),
                          )
                        : const SizedBox(),
                    // : Text(""),
                  ],
                );
              }),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
