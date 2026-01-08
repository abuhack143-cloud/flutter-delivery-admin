import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PersonalPictureController extends GetxController {
  var image = Rx<File?>(null);
  final picker = ImagePicker();
  File? myfile4;
}

class PersonalPictureControllerImp extends PersonalPictureController {
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      myfile4 = File(pickedFile.path);
    }
    update();
  }

  void showImageSourceDialog() {
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
        maxHeight: 180,
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose_image_source".tr,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
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
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.of(Get.context!).pop();
                    },
                    child: Center(
                      child: Text(
                        "camera".tr,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
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
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(Get.context!).pop();
                    },
                    child: Center(
                      child: Text(
                        "galary".tr,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
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
}
