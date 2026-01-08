import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color? color;
  final void Function()? onTap;
  const CustomCard({
    super.key,
    this.onTap,
    this.icon,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.grey.shade800,
                ),
              ),
            ),
          ),
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
    );
  }
}
