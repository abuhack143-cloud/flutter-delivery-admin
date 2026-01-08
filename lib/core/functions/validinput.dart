import 'package:get/get.dart';

 validInput(val, min, max, type) {
  if (type == 'username') {
    if (!RegExp(r'^[\p{L}\s]+$', unicode: true).hasMatch(val)) {
      return 'valid_username'.tr;
    }
  }

  if (type == 'email') {
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(val)) {
      return 'invalid_email'.tr;
    }
  }

  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(val)) {
      return 'valid_phone'.tr;
    }
  }

  if (val.isEmpty) {
    return 'field_required'.tr;
  }

  if (val.length < min) {
    return "${'min_length'.tr} $min ${'chara'.tr}";
  }

  if (val.length > max) {
    return "${'max_length'.tr} $max ${'chara'.tr}";
  }
}
