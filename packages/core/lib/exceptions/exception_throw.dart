import 'package:flutter/material.dart';
import 'package:core/core.dart';

bool canSubmitTextData(String text) {
  if (text == 'null') return false;
  return text.isNotEmpty;
}

Future<void> submitData({
  required BuildContext context,
  required List<String> texts,
  required List<String> textErrors,
  required Future<void> Function() updateData,
}) async {
  // If all fields are filled, proceed with individual field validation
  for (int i = 0; i < texts.length; i++) {
    if (!canSubmitTextData(texts[i])) {
      DialogsX.showErrorDialog(context,
          title: 'Warning', content: textErrors[i]);
      return;
    }
  }
  await updateData();
}
