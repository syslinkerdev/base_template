import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

PreviewDialog previewDialog = PreviewDialog();

enum ImageSourceType { network, file, asset }

class PreviewDialog {
  void image(
      {required BuildContext context,
      required String imagePath,
      required ImageSourceType sourceType,
      String title = 'Preview',
      IconData icon = Icons.close}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImagePreview(
          imagePath: imagePath,
          sourceType: sourceType,
          title: title,
          icon: icon,
        );
      },
    );
  }

  void fullImage(
      {required BuildContext context,
      required String imagePath,
      required ImageSourceType sourceType,
      String title = 'Preview',
      IconData icon = Icons.close}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FullImagePreview(
          imagePath: imagePath,
          sourceType: sourceType,
          title: title,
          icon: icon,
        );
      },
    );
  }
}

class ImagePreview extends StatelessWidget {
  final String imagePath;
  final ImageSourceType sourceType;
  final String title;
  final IconData icon;

  const ImagePreview({
    super.key,
    required this.imagePath,
    required this.sourceType,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorX.instance.ms.greyTransparent80(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyles.h6Gray(context)),
                InkWell(
                  child: Icon(icon, color: Colors.white, size: 30),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            _buildImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    switch (sourceType) {
      case ImageSourceType.network:
        return Image.network(imagePath);
      case ImageSourceType.file:
        return Image.file(File(imagePath));
      case ImageSourceType.asset:
        return Image.asset(imagePath);
      }
  }
}

class FullImagePreview extends StatelessWidget {
  final String imagePath;
  final ImageSourceType sourceType;
  final String title;
  final IconData icon;

  const FullImagePreview({
    super.key,
    required this.imagePath,
    required this.sourceType,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorX.instance.ms.greyTransparent80(context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: _buildImage()),
          ),
          Positioned(
            top: 40.0,
            left: 10.0,
            child: Text(title, style: TextStyles.h6Gray(context)),
          ),
          Positioned(
            top: 40.0,
            right: 10.0,
            child: InkWell(
              child: Icon(icon, color: Colors.white, size: 30),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    switch (sourceType) {
      case ImageSourceType.network:
        return Image.network(imagePath);
      case ImageSourceType.file:
        return Image.file(File(imagePath));
      case ImageSourceType.asset:
        return Image.asset(imagePath);
      }
  }
}
