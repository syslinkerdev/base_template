import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_assets/app_images.dart';

class CircularImageAvatar extends StatelessWidget {
  final void Function()? onTap;

  const CircularImageAvatar(
      {super.key,
      required this.image,
      this.modeEdit = false,
      this.onTap,
      this.radius});

  final dynamic image;
  final bool modeEdit;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: radius ?? context.sizeOfHeight * 0.07,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CircleAvatar(
              maxRadius: radius ?? context.sizeOfHeight * 0.07,
              backgroundColor: ColorX.instance.ms.transparent(context),
              child: image == null || image == ''
                  ? sysImages.profile.toWidget()
                  : image is String
                      ? ClipOval(
                          child: FadeInImageX(
                            imagePath: image,
                            fit: BoxFit.cover,
                            width: context.sizeOfHeight,
                            height: context.sizeOfHeight,
                            aniImage: true,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Center(
                                  child: sysImages.noInternet.toWidget(
                                height: context.sizeOfHeight * 0.08,
                                width: context.sizeOfWidth * 0.4,
                              ));
                            },
                          ),
                        )
                      : image is File
                          ? ClipOval(
                              child: Image.file(
                                image,
                                fit: BoxFit.cover,
                                width: context.sizeOfHeight,
                                height: context.sizeOfHeight,
                              ),
                            )
                          : sysImages.noInternet
                              .toWidget(), // Placeholder for other types
            ),
            if (modeEdit) ...[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      ColorX.instance.ms.transparent80(context),
                      Colors.transparent,
                    ],
                    stops: const [0.3, 0.3],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                width: context.sizeOfWidth,
                height: context.sizeOfHeight,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  color: ColorX.instance.sc.whiteSmoke,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
