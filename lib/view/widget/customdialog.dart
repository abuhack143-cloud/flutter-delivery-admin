import 'package:admin/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customDialog(String title, String button1, String? button2,
    void Function()? onTap, void Function()? onTap2, Color color) {
  showModalBottomSheet(
    backgroundColor: Theme.of(Get.context!).brightness == Brightness.dark
        ? Colors.black
        : Colors.white,
    barrierColor: Colors.grey.shade900.withOpacity(0.7),
    context: Get.context!,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    constraints: const BoxConstraints(
      maxHeight: 190,
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  onTap: onTap,
                  child: Center(
                    child: Text(
                      button1,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
            const Divider(),
            Expanded(
              child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  onTap: onTap2,
                  child: Center(
                    child: Text(
                      button2 ?? "cancel".tr,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      );
    },
  );
}

void customDialog2(String title, String button1, String button2,
    void Function()? onTap, void Function()? onTap2) {
  showModalBottomSheet(
    backgroundColor: Theme.of(Get.context!).brightness == Brightness.dark
        ? Colors.black
        : Colors.white,
    barrierColor: Colors.grey.shade900.withOpacity(0.7),
    context: Get.context!,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    constraints: const BoxConstraints(
      maxHeight: 190,
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.toString(),
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  onTap: onTap,
                  child: Center(
                    child: Text(
                      button1,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Appcolor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
            const Divider(),
            Expanded(
              child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  onTap: onTap2,
                  child: Center(
                    child: Text(
                      button2,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      );
    },
  );
}
