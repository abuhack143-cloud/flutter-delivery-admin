import 'package:admin/controller/order/acceptedOrder/acceptedOrder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class GenerateQRCodeScreen extends StatelessWidget {
  const GenerateQRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Order Scanner'),
      ),
      body: GetBuilder<OrderStatusControllerImp>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                cameraFacing: controller.cameraFacing,
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlay: controller.overlay,
              ),
            ),
          ],
        );
      }),
    );
  }
}
