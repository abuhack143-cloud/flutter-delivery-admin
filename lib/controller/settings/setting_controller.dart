import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/services/services.dart';
import 'package:jiffy/jiffy.dart';

class SettingController extends GetxController {
  void logout() {}
}

class SettingControllerImp extends SettingController {
  MyServices myServices = Get.find();
  ThemeMode? currentTheme;
  String? selectedValue;
  String? selectedLang;

  bool _isShowingSessionExpiredSnackbar = false;

  void showSessionExpiredAndLogout() {
    // امنع التكرار لو كانت الرسالة تُعرض بالفعل
    if (_isShowingSessionExpiredSnackbar) return;
    _isShowingSessionExpiredSnackbar = true;

    // عرض Snackbar قصير لمدة 3 ثواني
    Get.snackbar(
      'تنبيه', // عنوان اختياري، يمكنك جعله '' إن رغبت
      'تم انتهاء صلاحية الجلسة', // الرسالة المطلوبة
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(12),
      // يمكنك تخصيص الشكل كما تريد:
      // backgroundColor: Colors.black54,
      // colorText: Colors.white,
    );

    // بعد 3 ثوانٍ قم بتسجيل الخروج. لفاء الدالة try/catch لمنع كسر التطبيق.
    Future.delayed(Duration(seconds: 3), () {
      try {
        Get.find<SettingControllerImp>().logout();
      } catch (_) {}
      _isShowingSessionExpiredSnackbar = false;
    });
  }

  @override
  logout() {
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
  }

  void toggleTheme(String selectedTheme) async {
    if (selectedTheme == 'Dark') {
      currentTheme = ThemeMode.dark;
      await myServices.sharedPreferences.setString("theme", "dark");
    } else if (selectedTheme == 'Light') {
      currentTheme = ThemeMode.light;
      await myServices.sharedPreferences.setString("theme", "light");
    } else {
      currentTheme = ThemeMode.system;
      await myServices.sharedPreferences.remove("theme");
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();

    String? storedTheme = myServices.sharedPreferences.getString("theme");

    if (storedTheme == "dark") {
      currentTheme = ThemeMode.dark;
      selectedValue = 'Dark'.tr;
    } else if (storedTheme == "light") {
      currentTheme = ThemeMode.light;
      selectedValue = 'Light'.tr;
    } else {
      currentTheme = ThemeMode.system;
      selectedValue = 'System'.tr;
    }
    String? storedlang = myServices.sharedPreferences.getString("langt");
    if (storedlang == "العربية") {
      selectedLang = "العربية";
      Jiffy.setLocale("ar");
    } else if (storedlang == "English") {
      selectedLang = "English";
      Jiffy.setLocale("en");
    } else if (Get.deviceLocale!.languageCode == "ar") {
      selectedLang = "العربية";
      Jiffy.setLocale("ar");
    } else if (Get.deviceLocale!.languageCode == "en") {
      selectedLang = "English";
      Jiffy.setLocale("en");
    }
  }
}
