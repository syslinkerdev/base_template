import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorListenerWidget<T> extends ConsumerWidget {
  final ProviderBase<AsyncValue<T>> provider;
  final Widget child;

  const ErrorListenerWidget({
    super.key,
    required this.provider,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<T>>(
        provider, (prev, next) => next.showAlertDialogOnError(context));

    return child;
  }
}
