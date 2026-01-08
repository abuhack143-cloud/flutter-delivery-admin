import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/controller/test_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TestController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
        backgroundColor: Appcolor.primary,
      ),
      body: GetBuilder<TestController>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: ListView.builder(
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              return Text("${controller.data}");
            },
          ),
        );
      }),
    );
  }
}
