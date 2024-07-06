import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String image;
  final double size;
  final Color color;
  final Function()? onTap;
  const CircleImage({
    super.key,
    required this.image,
    required this.color,
    required this.onTap,
    this.size = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: ClipOval(
            child: Image(
              image: AssetImage(image),
              width: size,
              height: size,
            ),
          ),
        ),
      ),
    );
  }
}
