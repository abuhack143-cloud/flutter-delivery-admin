import 'package:admin/view/screen/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProfileDetail extends StatelessWidget {
  final String title;
  final dynamic image;

  final String? cache;
  final dynamic imageError;
  final String name;
  final String phone;
  final String whatsApp;
  final bool ifImage;
  final Color? color;
  final Widget Function(BuildContext, String)? placeholder;
  const CustomProfileDetail(
      {super.key,
      required this.title,
      this.image,
      required this.name,
      required this.phone,
      required this.whatsApp,
      required this.ifImage,
      this.imageError,
      this.color,
      this.placeholder,
      this.cache});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  )),
            ),
            const Divider(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ImageViewerPage(
                        imageUrl: ifImage ? image : imageError,
                        imageKey: cache ?? '',
                      ),
                      transition: Transition.cupertino,
                      gestureWidth: (context) =>
                          MediaQuery.of(context).size.width * 1.2,
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
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                      child: ifImage
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                height: double.infinity,
                                width: double.infinity,
                                imageUrl: image,
                                placeholder: placeholder,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                cacheKey: cache ?? '',
                              ),
                            )
                          : Image.asset(imageError),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Text(name),
                      Text(phone),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(whatsApp),
          ],
        ),
      ),
    );
  }
}
