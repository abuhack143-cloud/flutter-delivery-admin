import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageController extends GetxController {
  var image = Rx<File?>(null);
  final picker = ImagePicker();
  File? myfile;
}

class ImageControllerImp extends ImageController {
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      myfile = File(pickedFile.path);
    }
    update();
  }
}
