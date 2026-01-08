import 'dart:convert';
import 'package:admin/controller/home_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/linkapi.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;

MyServices myServices = Get.find();

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        var response =
            await http.post(Uri.parse(linkurl), body: data, headers: {
          'Accept': 'application/json',
          'X-Custom-Auth':
              'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
        });
        print(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postData2(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkurl),
          body: json.encode(data),
          headers: {
            'Accept': 'application/json',
            'X-Custom-Auth':
                'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postData3(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        MyServices myServices = Get.find();

        // 🔹 احصل على التوكن الحالي من التخزين

        String? token = Get.find<HomeControllerImp>().token;
        var response = await http.post(
          Uri.parse(linkurl),
          body: data,
          headers: {
            "Authorization": "Bearer $token",
            'Accept': 'application/json',
            'X-Custom-Auth':
                'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
          },
        );

        if (response.statusCode == 401 ||
            response.statusCode == 500 ||
            (response.statusCode == 200 &&
                response.body.contains("Expired token"))) {
          String? refreshToken = Get.find<HomeControllerImp>().refresh_token;
          if (refreshToken!.isEmpty) {
            return const Left(StatusRequest.serverfailure);
          }

          var refreshResponse =
              await http.post(Uri.parse(AppLink.refreshToken), body: {
            "refresh_token": refreshToken.toString()
          }, headers: {
            'X-Custom-Auth':
                'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
          });

          if (refreshResponse.statusCode == 200) {
            var responseBody = jsonDecode(refreshResponse.body);

            String? newToken = responseBody["access_token"];

            if (newToken == null) {
              return const Left(StatusRequest.serverfailure);
            }

            await myServices.sharedPreferences
                .setString("access_token", newToken);
            return await postData3(linkurl, data);
          } else {
            return const Left(StatusRequest.serverfailure);
          }
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postData4(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        MyServices myServices = Get.find();

        // 🔹 احصل على التوكن الحالي من التخزين
        String? token = Get.find<HomeControllerImp>().token;

        var response = await http.post(
          Uri.parse(linkurl),
          body: json.encode(data),
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
            'X-Custom-Auth':
                'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
          },
        );
        if (response.statusCode == 401 ||
            response.statusCode == 500 ||
            (response.statusCode == 200 &&
                response.body.contains("Expired token"))) {
          String? refreshToken = Get.find<HomeControllerImp>().refresh_token;

          if (refreshToken!.isEmpty) {
            return const Left(StatusRequest.serverfailure);
          }

          var refreshResponse =
              await http.post(Uri.parse(AppLink.refreshToken), body: {
            "refresh_token": refreshToken.toString()
          }, headers: {
            'X-Custom-Auth':
                'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
          });
          if (refreshResponse.statusCode == 200) {
            var responseBody = jsonDecode(refreshResponse.body);

            String? newToken = responseBody["access_token"];

            if (newToken == null) {
              return const Left(StatusRequest.serverfailure);
            }

            await myServices.sharedPreferences
                .setString("access_token", newToken);
            return await postData4(linkurl, data);
          } else {
            return const Left(StatusRequest.serverfailure);
          }
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postRequest3WithFile(
      String linkurl, Map data, file) async {
    try {
      if (await checkInternet()) {
        MyServices myServices = Get.find();

        // 🔹 احصل على التوكن الحالي من التخزين
        String? token = Get.find<HomeControllerImp>().token;

        var request = http.MultipartRequest("post", Uri.parse(linkurl));

        request.headers.addAll({
          "Authorization": "Bearer $token",
          // "Content-Type": "multipart/form-data",
          'X-Custom-Auth':
              'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
        });

        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile(
          "file",
          stream,
          length,
          filename: basename(file.path),
        );
        request.files.add(multipartFile);
        data.forEach((key, value) {
          request.fields[key] = value;
        });
        var myrequst = await request.send();
        var response = await http.Response.fromStream(myrequst);

        if (response.statusCode == 401 ||
            response.statusCode == 500 ||
            (response.statusCode == 200 &&
                response.body.contains("Expired token"))) {
          String? refreshToken = Get.find<HomeControllerImp>().refresh_token;

          if (refreshToken!.isEmpty) {
            return const Left(StatusRequest.serverfailure);
          }

          var refreshResponse =
              await http.post(Uri.parse(AppLink.refreshToken), body: {
            "refresh_token": refreshToken
          }, headers: {
            'X-Custom-Auth':
                'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
          }
                  // headers: {"Content-Type": "application/json"},
                  );

          if (refreshResponse.statusCode == 200) {
            var responseBody = jsonDecode(refreshResponse.body);
            String? newToken = responseBody["access_token"];
            if (newToken == null) {
              return const Left(StatusRequest.serverfailure);
            }

            await myServices.sharedPreferences
                .setString("access_token", newToken);
            print(newToken);
            return await postRequest3WithFile(linkurl, data, file);
          } else {
            return const Left(StatusRequest.serverfailure);
          }
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestWithFile(
      String linkurl, Map data, file) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest("post", Uri.parse(linkurl));
        request.headers.addAll({
          'X-Custom-Auth':
              'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}',
        });
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile(
          "file",
          stream,
          length,
          filename: basename(file.path),
        );
        request.files.add(multipartFile);
        data.forEach((key, value) {
          request.fields[key] = value;
        });
        var myrequst = await request.send();
        var response = await http.Response.fromStream(myrequst);
        if (myrequst.statusCode == 200 || myrequst.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return data[''];
        }
      } else {
        return left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestWith2File(
      String linkurl, Map data, file, file2, Map data2) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest("post", Uri.parse(linkurl));

        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile(
          "file",
          stream,
          length,
          filename: basename(file.path),
        );
        request.files.add(multipartFile);
        data.forEach((key, value) {
          request.fields[key] = value;
        });

        var length2 = await file2.length();
        var stream2 = http.ByteStream(file2.openRead());
        var multipartFile2 = http.MultipartFile(
          "file2",
          stream2,
          length2,
          filename: basename(file2.path),
        );
        request.files.add(multipartFile2);
        data2.forEach((key, value) {
          request.fields[key] = value;
        });
        var myrequst = await request.send();
        var response = await http.Response.fromStream(myrequst);
        if (myrequst.statusCode == 200 || myrequst.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestWith3File(
    String linkurl,
    Map data,
    file,
    file2,
    file3,
  ) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest("POST", Uri.parse(linkurl));

        // إضافة الملف الأول
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile(
          "file",
          stream,
          length,
          filename: basename(file.path),
        );
        request.files.add(multipartFile);

        // إضافة الملف الثاني
        var length2 = await file2.length();
        var stream2 = http.ByteStream(file2.openRead());
        var multipartFile2 = http.MultipartFile(
          "file2",
          stream2,
          length2,
          filename: basename(file2.path),
        );
        request.files.add(multipartFile2);

        // إضافة الملف الثالث
        var length3 = await file3.length();
        var stream3 = http.ByteStream(file3.openRead());
        var multipartFile3 = http.MultipartFile(
          "file3",
          stream3,
          length3,
          filename: basename(file3.path),
        );
        request.files.add(multipartFile3);

        data.forEach((key, value) {
          request.fields[key] = value;
        });

        // إرسال الطلب والحصول على الاستجابة
        var myrequst = await request.send();
        var response = await http.Response.fromStream(myrequst);
        if (myrequst.statusCode == 200 || myrequst.statusCode == 201) {
          if (response.body.startsWith("{") && response.body.endsWith("}")) {
            // Parse as JSON
            Map responseBody = jsonDecode(response.body);
            return Right(responseBody);
          } else {
            // Handle as non-JSON response

            return const Left(StatusRequest.serverfailure);
          }
        } else {
          return const Left(StatusRequest.serverfailure); // تصحيح هنا
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestWith4File(
    String linkurl,
    Map data,
    file,
    file2,
    file3,
    file4,
  ) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest("POST", Uri.parse(linkurl));

        // إضافة الملف الأول
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile(
          "file",
          stream,
          length,
          filename: basename(file.path),
        );
        request.files.add(multipartFile);

        // إضافة الملف الثاني
        var length2 = await file2.length();
        var stream2 = http.ByteStream(file2.openRead());
        var multipartFile2 = http.MultipartFile(
          "file2",
          stream2,
          length2,
          filename: basename(file2.path),
        );
        request.files.add(multipartFile2);

        // إضافة الملف الثالث
        var length3 = await file3.length();
        var stream3 = http.ByteStream(file3.openRead());
        var multipartFile3 = http.MultipartFile(
          "file3",
          stream3,
          length3,
          filename: basename(file3.path),
        );
        request.files.add(multipartFile3);

        data.forEach((key, value) {
          request.fields[key] = value;
        });

        // إضافة الملف الرابع
        var length4 = await file3.length();
        var stream4 = http.ByteStream(file3.openRead());
        var multipartFile4 = http.MultipartFile(
          "file4",
          stream4,
          length4,
          filename: basename(file4.path),
        );
        request.files.add(multipartFile4);

        data.forEach((key, value) {
          request.fields[key] = value;
        });
        // إرسال الطلب والحصول على الاستجابة
        var myrequst = await request.send();
        var response = await http.Response.fromStream(myrequst);
        if (myrequst.statusCode == 200 || myrequst.statusCode == 201) {
          if (response.body.startsWith("{") && response.body.endsWith("}")) {
            // Parse as JSON
            Map responseBody = jsonDecode(response.body);
            return Right(responseBody);
          } else {
            // Handle as non-JSON response

            return const Left(StatusRequest.serverfailure);
          }
        } else {
          return const Left(StatusRequest.serverfailure); // تصحيح هنا
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestWith5File(
    String linkurl,
    Map data,
    file,
    file2,
    file3,
    file4,
    file5,
  ) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest("POST", Uri.parse(linkurl));

        // إضافة الملف الأول
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile(
          "file",
          stream,
          length,
          filename: basename(file.path),
        );
        request.files.add(multipartFile);

        // إضافة الملف الثاني
        var length2 = await file2.length();
        var stream2 = http.ByteStream(file2.openRead());
        var multipartFile2 = http.MultipartFile(
          "file2",
          stream2,
          length2,
          filename: basename(file2.path),
        );
        request.files.add(multipartFile2);

        // إضافة الملف الثالث
        var length3 = await file3.length();
        var stream3 = http.ByteStream(file3.openRead());
        var multipartFile3 = http.MultipartFile(
          "file3",
          stream3,
          length3,
          filename: basename(file3.path),
        );
        request.files.add(multipartFile3);

        data.forEach((key, value) {
          request.fields[key] = value;
        });

        // إضافة الملف الرابع
        var length4 = await file3.length();
        var stream4 = http.ByteStream(file3.openRead());
        var multipartFile4 = http.MultipartFile(
          "file4",
          stream4,
          length4,
          filename: basename(file4.path),
        );
        request.files.add(multipartFile4);

        data.forEach((key, value) {
          request.fields[key] = value;
        });

        // إضافة الملف الخامس
        var length5 = await file3.length();
        var stream5 = http.ByteStream(file3.openRead());
        var multipartFile5 = http.MultipartFile(
          "file5",
          stream5,
          length5,
          filename: basename(file5.path),
        );
        request.files.add(multipartFile5);

        data.forEach((key, value) {
          request.fields[key] = value;
        });
        // إرسال الطلب والحصول على الاستجابة
        var myrequst = await request.send();
        var response = await http.Response.fromStream(myrequst);
        if (myrequst.statusCode == 200 || myrequst.statusCode == 201) {
          if (response.body.startsWith("{") && response.body.endsWith("}")) {
            // Parse as JSON
            Map responseBody = jsonDecode(response.body);
            return Right(responseBody);
          } else {
            // Handle as non-JSON response

            return const Left(StatusRequest.serverfailure);
          }
        } else {
          return const Left(StatusRequest.serverfailure); // تصحيح هنا
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestWith6File(
    String linkurl,
    Map data,
    file,
    file2,
    file3,
    file4,
    file5,
    file6,
  ) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest("POST", Uri.parse(linkurl));

        // إضافة الملف الأول
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile(
          "file",
          stream,
          length,
          filename: basename(file.path),
        );
        request.files.add(multipartFile);

        // إضافة الملف الثاني
        var length2 = await file2.length();
        var stream2 = http.ByteStream(file2.openRead());
        var multipartFile2 = http.MultipartFile(
          "file2",
          stream2,
          length2,
          filename: basename(file2.path),
        );
        request.files.add(multipartFile2);

        // إضافة الملف الثالث
        var length3 = await file3.length();
        var stream3 = http.ByteStream(file3.openRead());
        var multipartFile3 = http.MultipartFile(
          "file3",
          stream3,
          length3,
          filename: basename(file3.path),
        );
        request.files.add(multipartFile3);

        // إضافة الملف الرابع
        var length4 = await file4.length();
        var stream4 = http.ByteStream(file4.openRead());
        var multipartFile4 = http.MultipartFile(
          "file4",
          stream4,
          length4,
          filename: basename(file4.path),
        );
        request.files.add(multipartFile4);

        // إضافة الملف الخامس
        var length5 = await file5.length();
        var stream5 = http.ByteStream(file5.openRead());
        var multipartFile5 = http.MultipartFile(
          "file5",
          stream5,
          length5,
          filename: basename(file5.path),
        );
        request.files.add(multipartFile5);

        // إضافة الملف السادس
        var length6 = await file6.length();
        var stream6 = http.ByteStream(file6.openRead());
        var multipartFile6 = http.MultipartFile(
          "file6",
          stream6,
          length6,
          filename: basename(file6.path),
        );
        request.files.add(multipartFile6);
///////////////////////////////////////////////
        data.forEach((key, value) {
          request.fields[key] = value;
        });
        // إرسال الطلب والحصول على الاستجابة
        var myrequst = await request.send();
        var response = await http.Response.fromStream(myrequst);
        if (myrequst.statusCode == 200 || myrequst.statusCode == 201) {
          if (response.body.startsWith("{") && response.body.endsWith("}")) {
            // Parse as JSON
            Map responseBody = jsonDecode(response.body);
            return Right(responseBody);
          } else {
            // Handle as non-JSON response

            return const Left(StatusRequest.serverfailure);
          }
        } else {
          return const Left(StatusRequest.serverfailure); // تصحيح هنا
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }
}
