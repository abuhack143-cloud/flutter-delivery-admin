import 'package:flutter/widgets.dart';

class Backgroundimage extends StatelessWidget {
  const Backgroundimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        "images/background.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
