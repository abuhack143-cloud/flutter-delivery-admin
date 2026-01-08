import 'package:admin/core/class/StatusRequest.dart';

StatusRequest handlingData(response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
