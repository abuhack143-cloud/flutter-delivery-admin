// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:admin/core/constant/color.dart';
import 'package:admin/view/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class OrderQRCode extends StatelessWidget {
  final String orderNumber;

  const OrderQRCode({super.key, required this.orderNumber});

  /// 🔹 تحويل QR إلى صورة ومشاركتها
  Future<void> shareQRCode() async {
    try {
      // توليد QR كصورة
      final painter = QrPainter(
        data: orderNumber,
        version: QrVersions.auto,
        gapless: false,
        eyeStyle: const QrEyeStyle(color: Appcolor.primary),
        emptyColor: Colors.white,
      );

      // حفظ الصورة في الذاكرة
      final ByteData? bytes = await painter.toImageData(300);
      if (bytes == null) return;

      final Uint8List imageData = bytes.buffer.asUint8List();

      // حفظ الصورة مؤقتًا
      final tempDir = await getTemporaryDirectory();
      final file = File("${tempDir.path}/qr_code.png");
      await file.writeAsBytes(imageData);

      // مشاركة الصورة
      await Share.shareXFiles([XFile(file.path)],
          text: "QR Code للطلبية: $orderNumber");
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR".tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: QrImageView(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              foregroundColor: Appcolor.primary,
              data: orderNumber,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          CustomButton(
            text: "share".tr,
            minimumSize: const Size(220, 45),
            backgroundColor: Appcolor.primary,
            onTap: shareQRCode,
          )
        ],
      ),
    );
  }
}
