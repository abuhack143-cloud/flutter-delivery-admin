import 'package:admin/controller/other/term/term_controller.dart';
import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Term extends StatelessWidget {
  const Term({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TermController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "terms_conditions".tr,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<TermController>(builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onTap: () {
                      controller.border = false;
                      controller.update();
                    },
                    controller: controller.termText,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(
                          color:
                              controller.border ? Colors.green : Appcolor.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: const BorderSide(color: Appcolor.primary),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: "edit".tr,
                  minimumSize: const Size(335, 55),
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  backgroundColor: Appcolor.primary,
                  onTap: () {
                    controller.border = true;
                    FocusScope.of(context).unfocus();
                    controller.update();
                    controller.editTerm();
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
