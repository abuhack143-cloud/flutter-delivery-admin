import 'dart:io';
import 'dart:typed_data';
import 'package:admin/controller/account/admin/PersonalPicture_controller.dart';
import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image/image.dart' as img;
// import 'package:mime/mime.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:path/path.dart';

class AddAdminData {
  final Crud crud;

  final PersonalPictureControllerImp personal =
      Get.put(PersonalPictureControllerImp());

  AddAdminData(this.crud);

  // String _mimeOf(File? f) => f == null
  //     ? 'application/octet-stream'
  //     : (lookupMimeType(f.path) ?? 'application/octet-stream');

  Future<Uint8List> _makeFullJpeg(File f) async {
    final bytes = await f.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return bytes;

    const maxSide = 1600;
    img.Image out = decoded;
    if (decoded.width > maxSide || decoded.height > maxSide) {
      if (decoded.width >= decoded.height) {
        out = img.copyResize(decoded, width: maxSide);
      } else {
        out = img.copyResize(decoded, height: maxSide);
      }
    }
    return Uint8List.fromList(img.encodeJpg(out, quality: 82));
  }

  Future<Uint8List> _makeTinyJpeg(File f) async {
    final bytes = await f.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return bytes;

    const targetW = 320;
    final resized = img.copyResize(decoded, width: targetW);
    return Uint8List.fromList(img.encodeJpg(resized, quality: 55));
  }

  /// رفع الصورة مع البيانات مباشرة إلى addAdmin عبر Dio
  Future<Either<StatusRequest, Map>> addAdminWithR2({
    required String name,
    required String email,
    required String password,
    required String branch,
    required String role,
    CancelToken? cancelToken,
    void Function(double pct)? onOverallProgress,
  }) async {
    try {
      final file = personal.myfile4;
      if (file == null) return const Left(StatusRequest.serverfailure);

      // تحويل الصورة إلى JPEG Full و Tiny
      final fullBytes = await _makeFullJpeg(file);
      final tinyBytes = await _makeTinyJpeg(file);

      final fullFile = MultipartFile.fromBytes(
        fullBytes,
        filename: '${basenameWithoutExtension(file.path)}_full.jpg',
        // contentType: MediaType.parse('image/jpeg'),
      );

      final tinyFile = MultipartFile.fromBytes(
        tinyBytes,
        filename: '${basenameWithoutExtension(file.path)}_tiny.jpg',
        // contentType: MediaType.parse('image/jpeg'),
      );

      final formData = FormData.fromMap({
        "admin_name": name,
        "admin_email": email,
        "admin_password": password,
        "admin_branch": branch,
        "admin_role": role,
        "file_full": fullFile,
        "file_tiny": tinyFile,
      });

      final response = await crud.dio.post(
        AppLink.addAdmin,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: (sent, total) {
          if (onOverallProgress != null) {
            onOverallProgress(sent / total);
          }
        },
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map respData =
            response.data is Map ? response.data : {"data": response.data};
        return Right(respData);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<dynamic> getCity() async {
    var response = await crud.postData(AppLink.city, {});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getOwner(List<String> city) async {
    var response = await crud.postData(AppLink.otherOwner, {"cities": city});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> addOtherAdmin(String email, List<String> otherOwner) async {
    var response = await crud.postData(
        AppLink.addOtherAdmin, {"admin_email": email, "owner": otherOwner});
    return response.fold((l) => l, (r) => r);
  }
}
