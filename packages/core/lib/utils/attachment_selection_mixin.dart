import 'dart:io';

import 'package:core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

mixin AttachmentSelectionMixin {
  Future<List<File>> showImagesSelectionOptions(BuildContext context,
      {bool allowMultiple = false}) async {
    return await showModalBottomSheet<List<File>>(
            context: context,
            builder: (context) => SpacedRow(
                  margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () => _callMethod(
                            () => selectImageFromGallery(allowMultiple),
                            context),
                        icon: Icon(Icons.photo_library)),
                    IconButton(
                        onPressed: () => _callMethod(captureImage, context),
                        icon: Icon(Icons.camera_alt)),
                    IconButton(
                        onPressed: () => _callMethod(
                            () => selectImageFromLocal(allowMultiple), context),
                        icon: Icon(Icons.file_present)),
                    IconButton(onPressed: context.pop, icon: Icon(Icons.close))
                  ],
                )) ??
        <File>[];
  }

  Future<void> _callMethod(
    Future<List<File>> Function() function,
    BuildContext context,
  ) async {
    final fileRes = await function.call();
    if (!context.mounted) return;
    context.pop(fileRes);
  }

  Future<List<File>> captureImage() async {
    final XFile? selectedXFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 70);
    if (selectedXFile != null) return [File(selectedXFile.path)];
    return <File>[];
  }

  Future<List<File>> selectImageFromGallery(bool allowMultiple) async {
    if (allowMultiple) {
      final selectedXFiles = await ImagePicker().pickMultiImage();
      return selectedXFiles.map((xfile) => File(xfile.path)).toList();
    } else {
      final selectedXFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedXFile != null) return [File(selectedXFile.path)];
    }
    return <File>[];
  }

  Future<List<File>> selectImageFromLocal(bool allowMultiple) async {
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      dialogTitle: 'Upload Reports',
      withReadStream: true,
      allowMultiple: allowMultiple,
      allowedExtensions: <String>[
        'jpg',
        'png',
        'jpeg',
        'pdf',
        'DICOM',
        'gif',
        'docx'
      ],
    );
    if (pickerResult != null && pickerResult.files.isNotEmpty) {
      return pickerResult.files.map((e) => File(e.path!)).toList();
    }
    return <File>[];
  }
}
