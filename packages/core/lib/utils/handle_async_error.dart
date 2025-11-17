import 'dart:developer';

import 'package:core/core.dart';

Future<T> handleAsyncError<T>(
    {required String title, required Future<T> Function() operation}) async {
  try {
    await isNotConnectedThrowError();
    return await operation();
  } catch (e) {
    bool internetCheck = await isNotConnected();
    if (internetCheck == true) {
      rethrow;
    } else {
      log("error from: $title , error: $e here");
      // print("error from: $title , error: $e here");
      throw convertToAppException(title: title, exception: "$e here ");
    }
  }
}
