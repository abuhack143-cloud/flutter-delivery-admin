import 'package:admin/core/constant/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;
  final String imageKey;

  const ImageViewerPage(
      {super.key, required this.imageUrl, required this.imageKey});

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    final targetW = (350 * dpr).round(); // لو بتعرض 350px عرضًا
    final targetH = (200 * dpr).round();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          cacheKey: imageKey,
          fit: BoxFit.fill,
          memCacheWidth: targetW,
          memCacheHeight: targetH,
          maxWidthDiskCache: targetW,
          maxHeightDiskCache: targetH,
          filterQuality: FilterQuality.low,
          placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
            color: Appcolor.primary,
          )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      // body: Center(
      //   child: PhotoView(
      //     imageProvider: CachedNetworkImageProvider(
      //       imageUrl,
      //       cacheKey: imageKey,
      //     ),
      //   ),
      // ),
    );
  }
}
