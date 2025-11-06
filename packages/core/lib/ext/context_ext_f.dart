import 'package:flutter/material.dart';
import 'package:core/core.dart';

extension BuildContextExtF on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDakMode => colorScheme.brightness == Brightness.dark;
  void exit<T>([T? data]) => Navigator.of(this, rootNavigator: true).pop(data);
  void close<T>([T? data]) =>
      Navigator.of(this, rootNavigator: false).pop(data);
  double get sizeOfWidth => MediaQuery.sizeOf(this).width;
  double get sizeOfHeight => MediaQuery.sizeOf(this).height;
  ColorX get colorX => ColorX.instance;

  /// Unfocus keyboard if any input is focused
  Future<void> unfocusKeyboard({int milliseconds = 300}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
