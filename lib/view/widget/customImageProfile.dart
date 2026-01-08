import 'package:admin/view/screen/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomImageProfile extends StatelessWidget {
  final String image;
  final String? imageKey;
  const CustomImageProfile({super.key, required this.image,  this.imageKey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ImageViewerPage(
            imageUrl: image,
            imageKey: '',
          ),
          transition: Transition.cupertino,
          gestureWidth: (context) => MediaQuery.of(context).size.width * 1.2,
        );
      },
      child: Container(
        width: 70,
        height: 70,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
          ),
        ),
        child: CircleAvatar(
          radius: 45,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          backgroundImage: CachedNetworkImageProvider(image,cacheKey:imageKey??'' ),
        ),
      ),
    );
  }
}
