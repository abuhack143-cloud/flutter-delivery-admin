import 'package:flutter/material.dart';

class CustomStatusHome extends StatelessWidget {
  final String title;
  final String body;
  final Color? color;
  final void Function()? onTap;
  const CustomStatusHome(
      {super.key,
      required this.title,
      required this.body,
      this.color,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width *
                  0.03, // نسبة من عرض الشاشة
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width *
                  0.022, // تقليل الحجم قليلاً
              fontWeight:
                  FontWeight.w500, // جعل الوزن متوسطًا بدلًا من العادي
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
