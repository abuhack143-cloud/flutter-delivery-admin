import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:admin/core/services/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {}

class HomeControllerImp extends HomeController with WidgetsBindingObserver {
  var notiCount = "0";

  MyServices myServices = Get.find();

  Future<void> loadNotificationCount() async {
    final prefs = myServices.sharedPreferences;
    await prefs.reload(); // ✅ هذا هو المفتاح لحل مشكلتك
    final value = prefs.getString("noti") ?? "0";
    notiCount = value;
    update();
  }

  void updateNoti(String newValue) {
    int current = int.tryParse(notiCount) ?? 0;
    int toAdd = int.tryParse(newValue) ?? 0;
    int result = current + toAdd;

    notiCount = result.toString();
    myServices.sharedPreferences.setString("noti", result.toString());
    update();
  }

  void deleteNoti(String newValue) {
    notiCount = newValue.toString();
    myServices.sharedPreferences.setString("noti", newValue.toString());
    update();
  }

  void resetNoti() {
    myServices.sharedPreferences.setString("noti", "0");
    notiCount = "0";
    update();
  }

  final storage = const FlutterSecureStorage();

  Completer<GoogleMapController> mapController = Completer();
  late CameraPosition kGooglePlex;
  String? role;
  Future<void> storag() async {
    role = await storage.read(key: 'role');
    update();
  }

  String? token;
  Future<void> accessToken() async {
    token = await storage.read(key: 'access_token');
    update();
  }

  String? refresh_token;
  Future<void> refreshToken() async {
    refresh_token = await storage.read(key: 'refresh_token');
    update();
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    FirebaseMessaging.instance.subscribeToTopic("admin");
    FirebaseMessaging.instance.subscribeToTopic(
        "admin${myServices.sharedPreferences.getString('id')}");

    kGooglePlex = const CameraPosition(
      target: LatLng(27.025839, 17.459193),
      zoom: 5.4746,
    );
    storag();
    loadNotificationCount();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this); // ⬅️ نظف الذاكرة
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      loadNotificationCount();
    }
  }
}
