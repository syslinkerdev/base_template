import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_assets/app_images.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageField extends HookConsumerWidget with AttachmentSelectionMixin {
  const ImageField({
    super.key,
    required this.image,
    this.title = 'Add Image',
    required this.onChange,
  });

  final dynamic image; // File or String (URL)
  final String title;
  final void Function(dynamic image) onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = context.sizeOfHeight * 0.3;
    final initialImage = useMemoized(() => image); // true initial image
    final selectedImage = useState<dynamic>(image);

    return GestureDetector(
      onTap: () {
        final current = selectedImage.value;
        final hasImage = current != null && current.toString().isNotEmpty;
        //print(
        // 'ImageField tapped, current image: $current, hasImage: $hasImage');
        if (hasImage) {
          _previewImage(context, current);
        } else {
          _pickImage(context, selectedImage);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CaptionText(title: title, isRequired: true),
          ContainerX(
            height: height,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 4),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildImage(context, height, selectedImage.value),
                _buildButtonsOverlay(context, selectedImage, initialImage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsOverlay(
    BuildContext context,
    ValueNotifier<dynamic> selectedImage,
    dynamic initialImage,
  ) {
    return Stack(
      children: [
        // 👁 Preview
        Positioned(
          top: 0,
          right: 0,
          child: _iconBtn(
            context,
            Icons.remove_red_eye_outlined,
            onPressed: () => _previewImage(context, selectedImage.value),
          ),
        ),

        // ❌ Clear + 📸 Add
        Positioned(
          bottom: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _iconBtn(
                context,
                Icons.clear,
                onPressed: () {
                  selectedImage.value = null;
                  onChange(null); // 🔄 Update parent with null
                },
              ),
              const SizedBox(height: 12),
              _iconBtn(
                context,
                Icons.add_a_photo_outlined,
                onPressed: () => _pickImage(context, selectedImage),
              ),
            ],
          ),
        ),

        // 🔁 Reset
        Positioned(
          bottom: 0,
          left: 0,
          child: _iconBtn(
            context,
            Icons.refresh,
            onPressed: () {
              selectedImage.value = initialImage;
              onChange(initialImage); // ✅ Reset to original
            },
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(
    BuildContext context,
    ValueNotifier<dynamic> selectedImage,
  ) async {
    final files = await showImagesSelectionOptions(context);
    if (files.isEmpty) return;

    final file = files.first;
    selectedImage.value = file;
    onChange(file.path); // ✅ Pass File to parent
  }

  bool isNetworkImage(String imagePath) {
    final uri = Uri.tryParse(imagePath);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  void _previewImage(BuildContext context, dynamic image) {
    if (image == null) return;

    final path = image is File ? image.path : image.toString();
    final isNetwork = isNetworkImage(path);

    previewDialog.fullImage(
      context: context,
      imagePath: path,
      sourceType: isNetwork ? ImageSourceType.network : ImageSourceType.file,
    );
  }

  Widget _iconBtn(BuildContext context, IconData icon,
      {required VoidCallback onPressed}) {
    return CircleAvatar(
      backgroundColor: appColors.ms.whiteSwNero(context).withOpacity(0.7),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: appColors.ms.neroSwWhite(context)),
      ),
    );
  }

  Widget _buildImage(BuildContext context, double height, dynamic image) {
    if (image == null || image == '') {
      return sysImages.upload.toWidget();
    }

    if (image is String) {
      return FadeInImageX(
        imagePath: image,
        fit: BoxFit.contain,
        width: double.infinity,
        height: height,
        aniImage: true,
        imageErrorBuilder: (ctx, __, ___) => Center(
          child: sysImages.noInternet.toWidget(
            height: ctx.sizeOfHeight * 0.08,
            width: ctx.sizeOfWidth * 0.4,
          ),
        ),
      );
    }

    if (image is File) {
      return Image.file(
        image,
        fit: BoxFit.contain,
        width: double.infinity,
        height: height,
      );
    }

    return sysImages.noInternet.toWidget();
  }
}
