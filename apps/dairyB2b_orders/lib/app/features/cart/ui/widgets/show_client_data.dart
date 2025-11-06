import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/client_cache_provider.dart';

class ShowClientData extends HookConsumerWidget {
  const ShowClientData({super.key, required this.mode, required this.uid});
  final CartMode mode;
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ref.watch(ClientCacheProvider(uid: uid)).when(
          data: (clientData) {
            if (clientData == null) {
              return Text('No client data found');
            }
            return ShowUserWidget(mode: mode, user: clientData);
          },
          error: (error, stackTrace) =>
              Text(error.toString(), overflow: TextOverflow.fade),
          loading: () => ShimmerX(
              width: context.sizeOfWidth, height: context.sizeOfHeight * 0.08)),
    );
  }
}
