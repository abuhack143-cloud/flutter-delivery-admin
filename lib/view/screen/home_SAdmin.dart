import 'package:admin/view/widget/home/customGridView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
      init: HomeControllerImp(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("home".tr),
        ),
        body: SingleChildScrollView(
          child: Card(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.07,
                ),
                CustomGridView(
                  admins: controller.role != "admin_all" &&
                      controller.role != "admin_east" &&
                      controller.role != "admin_west" &&
                      controller.role != "admin_other",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
