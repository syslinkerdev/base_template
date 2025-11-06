import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuspendedScreen extends HookConsumerWidget {
  const SuspendedScreen({super.key, required this.user});
  final UserX user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.block, // changed to block icon for suspension
                size: 90,
                color: Colors.red,
              ),
              gapH16,
              Text(
                'Account Suspended',
                style: TextStyles.h6Bold(context)?.copyWith(
                  color: Colors.red[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapH12,
              Text(
                'Your account has been temporarily suspended.\n'
                'This may be due to a violation of our policies or other reasons.\n\n'
                'Account: "${user.phoneNumber}"\n\n'
                'Please contact your ${user.role == Role.client ? "Admin" : "App Management"} if you believe this is a mistake.\n',
                textAlign: TextAlign.center,
                style: TextStyles.h12Bold(context)
                    ?.copyWith(color: Colors.red[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
