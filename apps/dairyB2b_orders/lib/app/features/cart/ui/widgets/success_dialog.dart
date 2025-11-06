import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';

class CartSuccess extends HookConsumerWidget {
  const CartSuccess(this.mode, {super.key});

  final CartMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (title, description, buttonTxt) = _getTextForMode(mode);

    return Center(
      child: SpacedColumn(
        defaultHeight: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: appColors.sc.heartChakra,
            size: context.sizeOfHeight * 0.12,
          ),
          Text(title,
              style: TextStyles.h5Bold(context), textAlign: TextAlign.center),
          Text(description,
              style: TextStyles.h8Gray(context), textAlign: TextAlign.center),
          gapH20,
          ButtonX(
            label: buttonTxt,
            onPressed: () => context.close(true),
          ),
        ],
      ),
    );
  }

  /// Returns a title and description based on the CartMode
  (String title, String description, String buttonTxt) _getTextForMode(
      CartMode mode) {
    return switch (mode) {
      CartMode.newOrder => (
          'Order Placed!',
          'Your order has been placed\nsuccessfully.',
          'View Details'
        ),
      CartMode.edit => (
          'Order Edited!',
          'Your changes have been saved\nsuccessfully.',
          'View Details'
        ),
      CartMode.basket => (
          'Smart Basket\nCreated!',
          'Your Smart Basket has been\ncreated successfully.',
          'View Basket'
        ),
      CartMode.editBasket => (
          'Basket Updated!',
          'Your Smart Basket has been\nupdated successfully.',
          'View Basket'
        ),
    };
  }

  static Future<bool?> dialog(BuildContext context,
          {required CartMode mode}) async =>
      await DialogsX.showCustomDialog<bool>(context,
          content: CartSuccess(mode));
}
