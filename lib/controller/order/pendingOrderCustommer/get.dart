import 'dart:ui' as ui;
import 'package:flutter/painting.dart' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class PaintImage {
  Future<BitmapDescriptor> getMarkerIconFromUrl(
      String imageUrl, String image) async {
    try {
      // تحميل صورة الدليفري من URL
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) throw Exception("Failed to load image");
      Uint8List imageData = response.bodyBytes;

      // تحميل أيقونة الماركر الافتراضية (الحمراء)
      ByteData data = await rootBundle.load(image); // أضف صورة ماركر هنا
      Uint8List markerBytes = data.buffer.asUint8List();

      // تحويل صورتي الدليفري والماركر إلى ui.Image
      final ui.Codec markerCodec = await ui.instantiateImageCodec(
        markerBytes,
        targetWidth: 150,
      );
      final ui.FrameInfo markerFrameInfo = await markerCodec.getNextFrame();
      final ui.Image markerImage = markerFrameInfo.image;

      final ui.Codec deliveryCodec =
          await ui.instantiateImageCodec(imageData, targetWidth: 60);
      final ui.FrameInfo deliveryFrameInfo = await deliveryCodec.getNextFrame();
      final ui.Image deliveryImage = deliveryFrameInfo.image;

      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final ui.Canvas canvas = ui.Canvas(recorder);
      const double size = 150;
      canvas.save();
      canvas.translate(size / 2, size / 2);

      canvas.translate(-size / 2, -size / 2);

      // رسم أيقونة الماركر الأحمر كخلفية
      ui.paintImage(
        canvas: canvas,
        rect: const Rect.fromLTWH(0, 0, size, size),
        image: markerImage,
        fit: ui.BoxFit.cover,
      );
      canvas.restore();
      // رسم صورة الدليفري داخل دائرة في منتصف الماركر
      const double circleSize = 70;
      const double dy = 20; // تحريك الصورة قليلاً للأعلى داخل الماركر

      canvas.save();
      canvas.translate(size / 2, size / 2);

      canvas.translate(-size / 2, -size / 2);
      final ui.Paint circlePaint = ui.Paint()
        ..color = const ui.Color(0xFFFFFFFF) // لون الخلفية (أبيض)
        ..style = ui.PaintingStyle.fill
        ..isAntiAlias = true;
      canvas.drawCircle(const Offset(size / 2, dy + (circleSize / 2)),
          circleSize / 2, circlePaint);

      final ui.Path clipPath = ui.Path()
        ..addOval(Rect.fromCircle(
            center: const Offset(size / 2, dy + (circleSize / 2)),
            radius: circleSize / 2));
      canvas.clipPath(clipPath);

      ui.paintImage(
        canvas: canvas,
        rect: Rect.fromCircle(
            center: const Offset(size / 2, dy + (circleSize / 2)),
            radius: circleSize / 2),
        image: deliveryImage,
        fit: ui.BoxFit.cover,
      );
      canvas.restore();
      final ui.Image finalImage =
          await recorder.endRecording().toImage(size.toInt(), size.toInt());
      final ByteData? byteData =
          await finalImage.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List finalMarkerBytes = byteData!.buffer.asUint8List();

      // ignore: deprecated_member_use
      return BitmapDescriptor.fromBytes(finalMarkerBytes);
    } catch (e) {
      return BitmapDescriptor.defaultMarker;
    }
  }
}
