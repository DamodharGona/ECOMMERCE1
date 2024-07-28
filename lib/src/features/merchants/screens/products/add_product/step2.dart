import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

class Step2 extends StatelessWidget {
  final Function()? chooseProductImage;
  final Function()? chooseThumbnailImage;
  final List<File> productPhotosList;
  final File? thumbnailFile;

  const Step2({
    super.key,
    this.chooseProductImage,
    this.chooseThumbnailImage,
    required this.thumbnailFile,
    required this.productPhotosList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        thumbnailFile != null
            ? Image.file(thumbnailFile!)
            : UploadPhotos(
                chooseProductImage: chooseThumbnailImage,
                placeHolderText: 'Upload Thumbnail Image',
                height: 80,
              ),
        const SizedBox(height: 40),
        UploadPhotos(
          chooseProductImage: chooseProductImage,
          placeHolderText: 'Upload Product Image',
          height: 80,
        ),
        const SizedBox(height: 40),
        Visibility(
          visible: productPhotosList.isNotEmpty,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: productPhotosList
                    .map((e) => Image.file(
                          e,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UploadPhotos extends StatelessWidget {
  final Function()? chooseProductImage;
  final String placeHolderText;
  final double height;

  const UploadPhotos({
    super.key,
    this.chooseProductImage,
    required this.placeHolderText,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: chooseProductImage,
      child: SizedBox(
        height: height,
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [5, 10],
          padding: EdgeInsets.zero,
          radius: const Radius.circular(12),
          child: Center(
            child: Text(
              placeHolderText,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
