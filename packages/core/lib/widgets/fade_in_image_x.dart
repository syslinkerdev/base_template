import 'dart:io';

import 'package:flutter/material.dart';
import 'package:system_assets/app_images.dart';

class FadeInImageX extends StatelessWidget {
  const FadeInImageX({
    super.key,
    required this.imagePath,
    this.fit,
    this.height,
    this.width,
    this.imageErrorBuilder,
    this.aniImage = false,
  });

  final String imagePath;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final bool aniImage;
  final Widget Function(
          BuildContext context, Object error, StackTrace? stackTrace)?
      imageErrorBuilder;

  bool get _isNetwork {
    final uri = Uri.tryParse(imagePath);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    return _isNetwork
        ? FadeInImage.assetNetwork(
            fit: fit,
            height: height,
            width: width,
            imageErrorBuilder: imageErrorBuilder ??
                (context, error, stackTrace) =>
                    Center(child: sysImages.noInternet.toWidget()),
            placeholder: aniImage
                ? sysImages.loadingGifX.path
                : sysImages.imagePlaceHolderX.path,
            image: imagePath,
          )
        : Image.file(
            File(imagePath),
            fit: fit,
            height: height,
            width: width,
            errorBuilder: imageErrorBuilder ??
                (context, error, stackTrace) =>
                    Center(child: sysImages.noInternet.toWidget()),
          );
  }
}
