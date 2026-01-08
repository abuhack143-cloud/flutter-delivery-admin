import 'dart:convert';
import 'package:admin/controller/home_controller.dart';
import 'package:admin/controller/order/acceptedOrder/acceptedOrder_controller.dart';
import 'package:admin/controller/order/cityOrder/cityOrder_controller.dart';
import 'package:admin/controller/order/deliveryFail/deliveryFail_controller.dart';
import 'package:admin/controller/order/pendingOrder/pending2Order_controller.dart';
import 'package:admin/controller/order/pendingOrder/pending3Order_controller.dart';
import 'package:admin/controller/order/pendingOrder/pendingOrder_controller.dart';
import 'package:admin/controller/ordersPage_controller.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/view/screen/order/cityOrder/cityOrder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // الخلفية: فقط تحديث SharedPreferences
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  await prefs.reload();

  int currentCount = int.tryParse(prefs.getString("noti") ?? "0") ?? 0;
  prefs.setString("noti", (currentCount + 1).toString());

  switch (message.data["pagename"]) {
    case "mainpending0":
      currentCount = int.tryParse(prefs.getString("pending") ?? "0") ?? 0;
      prefs.setString("pending", (currentCount + 1).toString());
      break;
    case "maindelivery0":
      currentCount = int.tryParse(prefs.getString("delivering") ?? "0") ?? 0;
      prefs.setString("delivering", (currentCount + 1).toString());
      break;
    case "deliveryFail":
      currentCount = int.tryParse(prefs.getString("deliveryFail") ?? "0") ?? 0;
      prefs.setString("deliveryFail", (currentCount + 1).toString());
      break;
    case "maincancel1":
      currentCount = int.tryParse(prefs.getString("maincancel") ?? "0") ?? 0;
      prefs.setString("maincancel", (currentCount + 1).toString());
      break;
    case "city":
      currentCount = int.tryParse(prefs.getString("city") ?? "0") ?? 0;
      prefs.setString("city", (currentCount + 1).toString());
      break;
    case "mainpendingCustommer0":
      currentCount = int.tryParse(prefs.getString("custommer") ?? "0") ?? 0;
      prefs.setString("custommer", (currentCount + 1).toString());
      break;
    case "maindelivered1":
      currentCount = int.tryParse(prefs.getString("delivered") ?? "0") ?? 0;
      prefs.setString("delivered", (currentCount + 1).toString());
      break;
  }
}

Future<void> requestPermissionNotfication() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettingsIOS = DarwinInitializationSettings();
  const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        final Map<String, dynamic> data = jsonDecode(response.payload!);
        safeOnSelectNotification(data["pagename"], data);
      }
    },
  );

  // التحقق إذا التطبيق تم فتحه من إشعار عند Terminated
  final details =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (details != null &&
      details.didNotificationLaunchApp &&
      details.notificationResponse?.payload != null) {
    final Map<String, dynamic> data =
        jsonDecode(details.notificationResponse!.payload!);
    safeOnSelectNotification(data["pagename"], data);
  }
}

void fcmconfig() {
  FirebaseMessaging.onMessage.listen((message) {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'Location Service',
      channelDescription: 'Location tracking notifications',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    // تمرير البيانات كاملة كـ JSON في payload
    flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      notificationDetails,
      payload: jsonEncode(message.data),
    );

    refreshPage(message.data);
    showOrderNoti(message.data);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    safeOnSelectNotification(message.data["pagename"], message.data);
  });
}

void showOrderNoti(Map<String, dynamic> data) {
  OrdersPageController controller =
      Get.isRegistered<OrdersPageController>() ? Get.find() : Get.put(OrdersPageController());

  switch (data["pagename"]) {
    case "mainpending0":
      controller.updateNoti("pending", "1");
      break;
    case "maindelivery0":
      controller.updateNoti("delivering", "1");
      break;
    case "deliveryFail":
      controller.updateNoti("deliveryFail", "1");
      break;
    case "maincancel1":
      controller.updateNoti("maincancel", "1");
      break;
    case "city":
      controller.updateNoti("city", "1");
      break;
    case "mainpendingCustommer0":
      controller.updateNoti("custommer", "1");
      break;
    case "maindelivered1":
      controller.updateNoti("delivered", "1");
      break;
  }

  Get.find<HomeControllerImp>().updateNoti("1");
}

// نسخة آمنة من onSelectNotification
void safeOnSelectNotification(String? payload, [Map<String, dynamic>? data]) {
  if (payload == null) return;

  final pageData = data ?? {};
  String pageName = pageData["pagename"] ?? payload;
  String? pageId = pageData["pageid"];

  RegExp regExp = RegExp(r'\d+');
  String? number = regExp.stringMatch(pageName);

  switch (pageName) {
    case "mainpending0":
    case "mainpending1":
      Get.toNamed(AppRoute.mainpending,
          arguments: {"orderId": pageId, "targetTab": number});
      break;
    case "maindelivery0":
    case "maindelivery1":
      Get.toNamed(AppRoute.mainDelivery,
          arguments: {"orderId": pageId, "targetTab": number});
      break;
    case "city":
      Get.to(CityOrder(selectedOrderId: pageId));
      break;
    case "mainpendingCustommer0":
      Get.toNamed(AppRoute.mainpendingCustommer,
          arguments: {"orderId": pageId, "targetTab": number});
      break;
    case "maindelivered1":
      Get.toNamed(AppRoute.maindelivered,
          arguments: {"orderId": pageId, "targetTab": number});
      break;
    case "deliveryFail":
      Get.toNamed(AppRoute.deliveryFail, arguments: {"orderId": pageId});
      break;
    case "maincancel1":
      Get.toNamed(AppRoute.mainDelivery,
          arguments: {"orderId": pageId, "targetTab": number});
      break;
  }
}

void refreshPage(Map<String, dynamic> data) {
  if (Get.currentRoute == '/mainpending' && data["pagename"] == "mainpending1") {
    PendingOrderController controller1 = Get.put(PendingOrderController());
    controller1.refreshData();

    Pending2OrderControllerImp controller2 = Get.put(Pending2OrderControllerImp());
    controller2.refreshData();

    Pending3OrderControllerImp controller3 = Get.put(Pending3OrderControllerImp());
    controller3.refreshData();
  }

  if (Get.currentRoute == '/accepted' && data["pagename"] != "") {
    OrderStatusControllerImp controller = Get.put(OrderStatusControllerImp());
    controller.refreshData();
  }

  if (Get.currentRoute == '/cityorder' && data["pagename"] == "city") {
    CityOrderControllerImp controller = Get.put(CityOrderControllerImp());
    controller.refreshData();
  }

  if (Get.currentRoute == '/deliveryFail' && data["pagename"] == "deliveryFail") {
    DeliveryFailControllerImp controller = Get.put(DeliveryFailControllerImp());
    controller.viewOrders();
  }
}
