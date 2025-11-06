import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String?> uploadIfNeeded({
  required String? imagePath,
  required String storagePath,
  required Ref ref,
}) async {
  if (imagePath == null || imagePath.trim().isEmpty) return null;
  if (imagePath.startsWith('http')) return imagePath; // Already uploaded

  final file = File(imagePath);
  if (!await file.exists()) {
    throw Exception("File not found: $imagePath");
  }
  return await ref
      .read(firestoreServiceProvider)
      .uploadImage(imageFile: file, destinationStoragePath: storagePath);
}
