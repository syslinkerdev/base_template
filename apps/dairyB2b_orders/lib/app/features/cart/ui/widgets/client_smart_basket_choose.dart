import 'dart:async';

import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/base/smart_basket_model.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/client_cache_provider.dart';

class ChooseSmartBasket extends ConsumerWidget {
  const ChooseSmartBasket({
    super.key,
    required this.uid,
    required this.onSelect,
  });
  final String uid;
  final FutureOr<void> Function(SmartBasket smartBasket)? onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContainerX(
      margin: EdgeInsets.only(bottom: 4),
      child: ref.watch(ClientCacheProvider(uid: uid)).when(
          data: (clientData) {
            if (clientData == null) {
              return Text('No client data found');
            }
            return ChooseSmartBasketWidget(
                user: clientData, onSelect: onSelect);
          },
          error: (e, s) {
            return Text(e.toString(), overflow: TextOverflow.fade);
          },
          loading: () => ShimmerX(
              width: context.sizeOfWidth, height: context.sizeOfHeight * 0.06)),
    );
  }
}
