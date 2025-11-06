import 'package:flutter/material.dart';

enum AdjustmentMode {
  newOrder,
  modify,
  adjustment,
}
// modified

extension AdjustmentModeApi on AdjustmentMode {
  String get name => switch (this) {
        AdjustmentMode.newOrder => 'New Order',
        AdjustmentMode.modify => 'Modify Order',
        AdjustmentMode.adjustment => 'Adjust Order',
      };

  Color get color => switch (this) {
        AdjustmentMode.newOrder => const Color(0xFFA7F2E0), // 🟦 Pale Aqua
        AdjustmentMode.modify => const Color(0xFFE3C6A8), // 🟫 Light Sand
        AdjustmentMode.adjustment =>
          const Color(0xFFF4C2C2), // 🌸 Misty Rose Pink
      };

  /// Button label depending on mode
  String get actionButtonLabel => switch (this) {
        AdjustmentMode.newOrder => 'Place Order',
        AdjustmentMode.modify => 'Modify Order',
        AdjustmentMode.adjustment => 'Adjust Order',
      };

  /// Success message depending on mode
  String get successMessage => switch (this) {
        AdjustmentMode.newOrder => 'Order placed successfully of',
        AdjustmentMode.modify => 'Order modified successfully of',
        AdjustmentMode.adjustment => 'Order adjusted successfully of',
      };
}
