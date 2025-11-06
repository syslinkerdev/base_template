import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:uuid/uuid.dart';

class UnauthorizedAccessScreen extends HookConsumerWidget {
  const UnauthorizedAccessScreen({super.key, required this.user});
  final UserX user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      bool hasTriggered = false;

      Future.microtask(() async {
        if (hasTriggered) return;
        hasTriggered = true;

        await sendUnauthorizedUserAlert(ref, context); // 🔔 alert admin

        await Future.delayed(
            const Duration(milliseconds: 200)); // give user time to read

        if (context.mounted) {
          await ref.read(phoneNoVerifyServiceProvider).signOut();
        }
      });

      return null;
    }, const []);

    return Scaffold(
      backgroundColor: Colors.red[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  size: 80, color: Colors.red),
              gapH16,
              Text(
                'Access Denied',
                style: TextStyles.h6Bold(context)?.copyWith(
                  color: Colors.red[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapH12,
              Text(
                'You are not authorized to access this app.\n'
                'Your current role is "${user.role?.name}".\n'
                'Please uninstall this app or contact support if this is a mistake.\n'
                'You will be logged out shortly.',
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

  Future<void> sendUnauthorizedUserAlert(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final String id = Uuid().v4();
    final String route = RouteX.getCurrentRoute(context);

    // Get platform metadata and app version
    final meta = await DeviceUtils.getPlatformMetadata();
    final appVersion = await AppUtils.getFullAppVersion();

    // ✅ Add app version to metadata
    meta['app_version'] = appVersion;

    final logData = LogModel(
      id: id,
      type: LogType.unauthorizedAccess,
      message:
          'Unauthorized access attempt by ${user.firstName} ${user.lastName} on $route',
      createdAt: DFU.now(),
      route: route,
      userId: user.uid,
      userName: '${user.firstName} ${user.lastName}',
      userRole: user.role,
      metadata: meta,
    );
    await ref.read(firestoreServiceProvider).setDocument(
          collectionPath: DbPathManager.logs(),
          documentId: id,
          data: logData.toDocument(),
        );

    //debugPrint(
    // "🚨 Unauthorized login attempt by ${user.firstName} ${user.lastName} logged.");
  }
}
