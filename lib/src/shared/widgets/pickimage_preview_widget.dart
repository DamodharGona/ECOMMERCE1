import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';

class PickimagePreviewWidget extends StatelessWidget {
  final Function()? bottomSheet;
  final String imageUrl;
  final String name;
  final String placeholderText;

  const PickimagePreviewWidget({
    super.key,
    this.bottomSheet,
    required this.imageUrl,
    required this.name,
    required this.placeholderText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: bottomSheet,
      child: SizedBox(
        height: 100,
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [5, 10],
          radius: const Radius.circular(12),
          child: name.isNotEmpty
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          height: 90,
                          width: 90,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    placeholderText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
        ),
      ),
    );
  }
}
