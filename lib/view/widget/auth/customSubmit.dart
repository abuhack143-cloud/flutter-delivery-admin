import 'package:flutter/material.dart';
import 'package:admin/core/constant/color.dart';

class Customsubmit extends StatelessWidget {
  final void Function()? onPressed;
  const Customsubmit({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -30,
      left: 55,
      child: SizedBox(
        width: 280,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: MaterialButton(
                color: Appcolor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: onPressed,
                child: const Icon(
                  Icons.arrow_forward,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
