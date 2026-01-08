import 'package:flutter/material.dart';

class CustomAccount extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool showNoti;
  final String count;

  final void Function()? onTap;
  const CustomAccount(
      {super.key,
      required this.text,
      this.icon,
      this.onTap,
      this.showNoti = false,
      this.count = "0"});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(9),
                  child: Icon(
                    icon,
                    size: MediaQuery.of(context).size.height * 0.04,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                showNoti
                    ? Positioned(
                        top: -2,
                        left: Directionality.of(context) == TextDirection.rtl
                            ? null
                            : 2,
                        right: Directionality.of(context) == TextDirection.rtl
                            ? 2
                            : null,
                        child: Container(
                            padding: const EdgeInsets.all(1),
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
                                count.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            // إخفاء الدائرة لو العدد صفر
                            ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height * 0.04,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
