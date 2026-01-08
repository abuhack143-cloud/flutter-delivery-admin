import 'dart:convert';
import 'dart:io';
import 'package:admin/controller/home_controller.dart';
import 'package:admin/controller/settings/setting_controller.dart';
import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/functions/checkinternet.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/linkapi.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData, Response;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Crud {
  final Dio _dio;
  Dio get dio => _dio;
  bool _isRefreshing = false;
  MyServices myServices = Get.find();

  Crud({String? baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl ?? AppLink.server,
          connectTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(minutes: 20),
          sendTimeout: Duration(minutes: 20),
          headers: {
            'Accept': 'application/json',
          },
          responseType: ResponseType.json,
          validateStatus: (code) => code != null && code < 400,
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await myServices.readSanitizedToken();
        if (token != null) {
          options.headers["Authorization"] = 'Bearer $token';
        }
        options.headers['X-Custom-Auth'] =
            'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}';
        handler.next(options);
      },
      onError: (e, handler) async {
        final isUnauthorized = e.response?.statusCode == 401 ||
            e.response?.statusCode == 500 ||
            (e.response?.statusCode == 200 &&
                e.message!.contains("Expired token"));
        final hasTried = (e.requestOptions.extra['retried'] == true);

        if (isUnauthorized && !hasTried) {
          if (_isRefreshing) {
            await _waitUntil(() => !_isRefreshing);
          } else {
            _isRefreshing = true;
            try {
              final refreshed = await _tryRefreshToken();
              if (!refreshed) {
                // فشل الريفريش => نفّذ تسجيل الخروج ثم أعد توجيه الخطأ
                try {
                  Get.find<SettingControllerImp>()
                      .showSessionExpiredAndLogout();
                } catch (_) {}
                _isRefreshing = false;
                return handler.next(e);
              }
            } finally {
              _isRefreshing = false;
            }
          }

          try {
            final newToken = await myServices.readSanitizedToken();
            final req = e.requestOptions;

            final newData = await _rebuildRequestData(req);

            final newExtra = Map<String, dynamic>.from(req.extra);
            newExtra['retried'] = true;
            final newOptions = RequestOptions(
              path: req.path,
              method: req.method,
              baseUrl: req.baseUrl,
              data: newData,
              queryParameters: req.queryParameters,
              headers: {
                ...req.headers,
                if (newToken != null && newToken.isNotEmpty)
                  'Authorization': 'Bearer $newToken',
                'X-Custom-Auth':
                    'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}'
              },
              responseType: req.responseType,
              contentType: req.contentType,
              followRedirects: req.followRedirects,
              receiveTimeout: req.receiveTimeout,
              sendTimeout: req.sendTimeout,
              validateStatus: req.validateStatus,
              extra: newExtra,
            );
            final response = await _dio.fetch(newOptions);
            return handler.resolve(response);
          } catch (_) {
            return handler.next(e);
          }
        }
        handler.next(e);
      },
    ));
  }

  Future<void> _waitUntil(
    bool Function() condition, {
    Duration checkEvery = const Duration(milliseconds: 80),
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final start = DateTime.now();
    while (!condition()) {
      await Future.delayed(checkEvery);
      if (DateTime.now().difference(start) > timeout) break;
    }
  }

  Future<bool> _tryRefreshToken() async {
    try {
      final old = await myServices.readRefreshToken();
      if (old == null || old.isEmpty) return false;

      final isWindows = Platform.isWindows;
      final res = await _dio.post(
        AppLink.refreshToken,
        data: {
          "refresh_token": old.toString(),
          "device_type": isWindows ? 'desktop' : 'mobile',
        },
        options: Options(
          headers: {
            // 'Authorization': 'Bearer $old',
            'X-Custom-Auth':
                'Basic ${base64Encode(utf8.encode('abdulhadee:abdulhadee@12'))}'
          },
        ),
      );
      if ((res.statusCode ?? 0) >= 200 && (res.statusCode ?? 0) < 300) {
        final data = res.data;
        String? newToken;
        if (data is Map) {
          newToken =
              (data['access_token'] ?? data['token'] ?? data['data']?['token'])
                  ?.toString();
        }

        if (newToken != null && newToken.isNotEmpty) {
          await myServices.saveToken(newToken); // يحدّث الكاش + التخزين
          return true;
        }
      }

      return false;
    } catch (_) {
      return false;
    }
  }

  Future<dynamic> _rebuildRequestData(RequestOptions req) async {
    final extra = req.extra;
    if (extra['__multipart'] == true) {
      final Map<String, dynamic> fields = Map<String, dynamic>.from(
        extra['__fields'] as Map,
      );
      final List files = (extra['__files'] as List);
      final String filesFieldName =
          (extra['__filesFieldName'] as String?) ?? 'files';

      final form = FormData();
      fields.forEach((k, v) => form.fields.add(MapEntry(k, '$v')));
      for (int i = 0; i < files.length; i++) {
        final MultipartFile mf = files[i] as MultipartFile;
        // إعادة الإضافة بنفس الترتيب والاسم
        form.files.add(MapEntry('$filesFieldName[$i]', mf));
      }
      return form;
    }

    if (extra.containsKey('__jsonBody')) {
      return extra['__jsonBody'];
    }

    // GET أو ما عنده جسم
    return req.data;
  }

  Either<StatusRequest, Map<String, dynamic>> _asEither(Response res) {
    final ct = (res.headers['content-type']?.join(',') ?? '').toLowerCase();
    final isJson = ct.contains('application/json');
    if (!isJson) return const Left(StatusRequest.serverfailure);

    final dynamic data = res.data;

    final Map<String, dynamic> map =
        data is Map<String, dynamic> ? data : {'data': data};

    return Right(map);
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> getData(
    String url, {
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlinefailure);
      }
      final res = await _dio.get(
        url,
        queryParameters: query,
        cancelToken: cancelToken,
      );
      return _asEither(res);
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postData(
    String url,
    Map<String, dynamic> body, {
    CancelToken? cancelToken,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlinefailure);
      }
      final res = await _dio.post(
        url,
        data: body,
        cancelToken: cancelToken,
        options: Options(extra: {'__jsonBody': body}),
      );
      return _asEither(res);
    } catch (e) {
      if (e is DioException && e.response != null) {
        return _asEither(e.response!); // <<ـ هنا السحر
      }
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> putData(
    String url,
    Map<String, dynamic> body, {
    CancelToken? cancelToken,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlinefailure);
      }
      final res = await _dio.put(
        url,
        data: body,
        cancelToken: cancelToken,
        options: Options(extra: {'__jsonBody': body}),
      );
      return _asEither(res);
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> deleteData(
    String url, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlinefailure);
      }
      final res = await _dio.delete(
        url,
        data: body,
        cancelToken: cancelToken,
        options: Options(extra: {'__jsonBody': body}),
      );
      return _asEither(res);
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> uploadMultipart(
    String url, {
    required Map<String, dynamic> fields,
    required List<MultipartFile> files,
    String filesFieldName = 'files',
    CancelToken? cancelToken,
    void Function(int sent, int total)? onSendProgress,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlinefailure);
      }

      final formData = FormData();

      // الحقول
      fields.forEach((k, v) {
        if (v != null) formData.fields.add(MapEntry(k, v.toString()));
      });

      // الملفات
      final useArrayName = filesFieldName.endsWith('[]');
      for (int i = 0; i < files.length; i++) {
        final key = useArrayName ? filesFieldName : '$filesFieldName[$i]';
        formData.files.add(MapEntry(key, files[i]));
      }

      final res = await _dio.post(
        url,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        options: Options(
          contentType: 'multipart/form-data',
          extra: {
            '__multipart': true,
            '__fields': fields,
            '__files_len': files.length,
            '__filesFieldName': filesFieldName,
          },
        ),
      );
      return _asEither(res);
    } catch (e) {
      if (e is DioException && e.response != null) {
        return _asEither(e.response!); // نُرجع JSON الخطأ من Laravel كما هو
      }
      return const Left(StatusRequest.serverException);
    }
  }

  void enableLogging() {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  Future<Either<StatusRequest, Map>> postRequestWithFileJWT(
      String linkurl, Map data, file) async {
    try {
      if (await checkInternet()) {
        MyServices myServices = Get.find();

        // 🔹 احصل على التوكن الحالي من التخزين
        String? token = myServices.sharedPreferences.getString("access_token");

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
          String? refreshToken =
              myServices.sharedPreferences.getString("refresh_token");

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

            return await postRequestWithFileJWT(linkurl, data, file);
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
}
