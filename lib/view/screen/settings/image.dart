import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;
  final String? imagekey;
  final bool ifImage;
  const ImageViewerPage(
      {super.key, required this.imageUrl, this.ifImage = true, this.imagekey});

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
      ),
      body: Center(
        child: PhotoView(
          imageProvider: ifImage
              ? CachedNetworkImageProvider(imageUrl, cacheKey: imagekey)
              : AssetImage(imageUrl),
        ),
      ),
    );
  }
}
