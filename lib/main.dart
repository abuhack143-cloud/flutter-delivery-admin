import 'package:admin/core/constant/color.dart';
import 'package:admin/core/functions/fcmconfig.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:admin/bindings/binding.dart';
import 'package:admin/controller/settings/setting_controller.dart';
import 'package:admin/core/localization/translation.dart';
import 'package:admin/routes.dart';
import 'package:admin/core/services/services.dart';
import 'package:get_storage/get_storage.dart';
import 'core/localization/changelocal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await requestPermissionNotfication();
 await  initializeNotifications();

   final details =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (details != null && details.didNotificationLaunchApp) {
    safeOnSelectNotification(details.notificationResponse?.payload);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    Get.lazyPut(() => SettingControllerImp());
    final commonTextTheme = TextTheme(
      titleMedium: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.03,
          fontWeight: FontWeight.normal,
          fontFamily: 'NotoSans'),
      bodyMedium: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.03,
          fontWeight: FontWeight.normal,
          fontFamily: 'NotoSans',
          height: 2),
      bodySmall: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.03,
          fontWeight: FontWeight.normal,
          fontFamily: 'NotoSans'),
      bodyLarge: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.03,
          fontWeight: FontWeight.normal,
          fontFamily: 'NotoSans'),
    );

    return GetBuilder<SettingControllerImp>(builder: (settingController) {
      return GetMaterialApp(
        translations: MyTranslation(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        locale: controller.language,
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Appcolor.primary,
            selectionColor: Appcolor.primary,
            selectionHandleColor: Appcolor.primary,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade200,
            surfaceTintColor: Colors.grey.shade200,
            // shape: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            titleTextStyle: const TextStyle(color: Colors.black, fontSize: 23),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          textTheme: commonTextTheme,
          scaffoldBackgroundColor: Colors.grey.shade200,
        ),

        /////////////////dark

        darkTheme: ThemeData.dark().copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Appcolor.primary,
            selectionColor: Appcolor.primary,
            selectionHandleColor: Appcolor.primary,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.black,
            // shape: Border(bottom: BorderSide(color: Colors.grey.shade800)),
            titleTextStyle: TextStyle(fontSize: 23),
          ),
          textTheme: commonTextTheme,
          scaffoldBackgroundColor: Colors.black,
        ),
        themeMode: settingController.currentTheme!,
        initialBinding: InBinding(),
        getPages: routes,
        builder: (context, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.grey.shade200,
              statusBarIconBrightness:
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark, // لرموز سوداء → وضع فاتح
              statusBarBrightness:
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark, // لأجهزة iOS
            ),
            child: SafeArea(
              child: child!,
            ),
          );
        },
      );
    });
  }
}
