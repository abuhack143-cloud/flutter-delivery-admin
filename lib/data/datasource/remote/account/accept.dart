import 'package:admin/controller/account/Image_controller.dart';
import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

class AcceptData {
  Crud crud;
  AcceptData(this.crud);

  ImageControllerImp controller = Get.put(ImageControllerImp());

  Future detailDelivery(String id) async {
    var response = await crud.postData(
      AppLink.detaildelivery,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future detailDeliveryAccept(
      String id, String adminId, String deliveryName) async {
    var response = await crud.postData(
      AppLink.detaildAccept,
      {
        "id": id,
        "adminId": adminId,
        "deliveryName": deliveryName,
      },
      // controller.myfile,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<bool> postDataToTelegram(
    String chatId,
    String caption,
  ) async {
    try {
      // استدعاء الكنترولر للحصول على الصورة

      // رابط الـ API

      // String chatId = "-1002591981523";
      String botToken = "8051381790:AAE2N1NwvyoWSTVeJgoh7UIj8JwJ7QEGqEo";

      final url = "https://api.telegram.org/bot$botToken/sendPhoto";

      // تجهيز الـ FormData
      final formData = FormData.fromMap({
        'chat_id': chatId,
        'caption': caption,
        'photo': await MultipartFile.fromFile(
          controller.myfile!.path,
          filename: controller.myfile!.path.split('/').last,
        ),
      });

      // تهيئة Dio
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
      ));

      // إرسال الطلب
      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200 && response.data['ok'] == true) {
        print("✅ تم إرسال الصورة بنجاح إلى تليجرام");
        return true;
      } else {
        print("⚠️ فشل الإرسال: ${response.data}");
        return false;
      }
    } catch (e) {
      print("❌ خطأ أثناء إرسال الصورة إلى Telegram: $e");
      return false;
    }
  }

  Future detailDeliveryReject(
    String id,
    String checkPic,
    String front,
    String back,
    String carmanu,
    String tech,
    String profile,
  ) async {
    var response = await crud.postData(
      AppLink.detaildRject,
      {
        "id": id,
        "checkPic": checkPic,
        "front": front,
        "back": back,
        "carmanu": carmanu,
        "tech": tech,
        "profile": profile
      },
    );

    return response.fold((l) => l, (r) => r);
  }

  Future detailowner(String id) async {
    var response = await crud.postData(
      AppLink.detailowner,
      {"id": id},
    );

    return response.fold((l) => l, (r) => r);
  }

  Future detailownerAccept(String id, String adminId, String ownerName) async {
    var response = await crud.postData(
      AppLink.detaildownerAccept,
      {
        "id": id,
        "adminId": adminId,
        "ownerName": ownerName,
      },
      // controller.myfile,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future detailownerReject(
    String id,
    String profile,
    String passport,
  ) async {
    var response = await crud.postData(
      AppLink.detaildownerRject,
      {
        "id": id,
        "profile": profile,
        "passport": passport,
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}
