import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp(){
  Get.defaultDialog(
    title: "warning",
    middleText: "do you want to exit",
      actions: [
        ElevatedButton(onPressed: (){exit(0);}, child: const Text("confirm"),),
        ElevatedButton(onPressed: (){Get.back();}, child: const Text("cancel"))
      ]

  );
  return Future.value(true);
}