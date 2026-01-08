import 'package:admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  late FlutterSecureStorage storage;
  String? _memToken;
  String? _memTokenRefresh;
  String? get memTokenRefresh => _memTokenRefresh;
  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    storage = FlutterSecureStorage();
    return this;
  }

  clear() async {
    sharedPreferences.clear();
    await sharedPreferences.reload();
  }

  String _sanitizeToken(String raw) =>
      raw.replaceFirst(RegExp(r'^Bearer\s+', caseSensitive: false), '').trim();
  Future<void> saveToken(String token) async {
    final sanitized = _sanitizeToken(token);
    _memToken = sanitized;
    await storage.write(key: "jwt", value: sanitized);
  }

  Future<void> saveRefreshToken(String token) async {
    final sanitized = _sanitizeToken(token);
    _memTokenRefresh = sanitized;
    await storage.write(key: "jwtRefresh", value: sanitized);
  }

  Future<String?> getToken() => storage.read(key: "jwt");
  Future<String?> getRefreshToken() => storage.read(key: "jwtRefresh");

  Future<String?> readSanitizedToken() async {
    if (_memToken != null && _memToken!.isNotEmpty)
      return _memToken; // 👈 استخدم الكاش
    final raw = await getToken();
    if (raw == null || raw.trim().isEmpty) return null;
    _memToken = _sanitizeToken(raw);
    return _memToken;
  }

  Future<String?> readRefreshToken() async {
    if (_memTokenRefresh != null && _memTokenRefresh!.isNotEmpty)
      return _memTokenRefresh; // 👈 استخدم الكاش
    final raw = await getRefreshToken();
    if (raw == null || raw.trim().isEmpty) return null;
    _memTokenRefresh = _sanitizeToken(raw);
    return _memTokenRefresh;
  }

  Future<void> clearToken() async {
    await storage.delete(key: "jwt");
    await storage.delete(key: "jwtRefresh");
    _memToken = null; // 👈 نظّف الكاش
    _memTokenRefresh = null;
  }
}

Future<void> initialServices() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() => MyServices().init());
}
