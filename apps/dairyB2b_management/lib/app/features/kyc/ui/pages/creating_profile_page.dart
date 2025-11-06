import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/kyc/providers/creating_profile_provider.dart';

class CreatingProfile extends HookConsumerWidget {
  const CreatingProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creatingProfileAsync = ref.watch(creatingProfileXProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Center(
        child: creatingProfileAsync.when(
          data: (_) => Text('Profile created successfully!',
              style: TextStyles.h6Bold(context)),
          loading: () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingIndicatorX(),
              gapH16,
              Text('Creating profile, please wait...',
                  style: TextStyles.h6Bold(context))
            ],
          ),
          error: (error, stack) => ErrorScreen(
            error: error,
            onRetry: () => ref.invalidate(creatingProfileXProvider),
          ),
        ),
      ),
    );
  }
}
