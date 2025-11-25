import 'dart:io';

import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> checkAppUpdate({
  required String appName,
  required BuildContext context,
  required WidgetRef ref,
}) async {
  try {
    // Fetch AppUpdateInfo from repo
    final AppUpdateInfo? updateInfo = await ref
        .read(dairyB2bRepositoryProvider)
        .fetchAppUpdate(appName: appName);

    if (updateInfo == null || updateInfo.isEmpty) return;

    final latestVersion = updateInfo.version;
    final apkUrl = updateInfo.url;

    if (latestVersion.isEmpty || apkUrl.isEmpty) return;

    // Get current app version from .env
    final currentVersion = AppEnv.version;

    if (_isVersionGreater(latestVersion, currentVersion)) {
      if (!context.mounted) return;
      DialogsX.showCustomDialog(
        context,
        barrierDismissible: false,
        content: Builder(
          builder: (context) {
            double progress = 0.0;
            bool isDownloading = false;

            return StatefulBuilder(
              builder: (context, setState) {
                Future<void> startDownload() async {
                  try {
                    // print("🚀 START: Update download initiated");
                    // print("🔗 APK URL: $apkUrl");

                    setState(() {
                      isDownloading = true;
                    });

                    // 1️⃣ Get download directory
                    final dir = await getExternalStorageDirectory();
                    final filePath =
                        '${dir!.path}/${AppEnv.appName.toLowerCase()}_update.apk';
                    // print("📂 Download directory: ${dir.path}");
                    // print("📄 Saving to: $filePath");

                    // 2️⃣ Start HTTP download
                    // print("🌐 Requesting APK...");
                    final request =
                        await HttpClient().getUrl(Uri.parse(apkUrl));
                    final response = await request.close();
                    // print(
                    //     "📥 Response received. Content-Length: ${response.contentLength}");

                    final file = File(filePath);
                    final raf = file.openSync(mode: FileMode.write);

                    int received = 0;
                    final total = response.contentLength;

                    // 3️⃣ Stream chunks
                    // print("⬇️ Starting chunk download...");
                    await for (final chunk in response) {
                      received += chunk.length;
                      raf.writeFromSync(chunk);

                      progress = total > 0 ? received / total : 0;

                      // print("📦 Chunk received: ${chunk.length} bytes — "
                      //     "Progress: ${(progress * 100).toStringAsFixed(2)}% "
                      //     "($received / $total)");

                      setState(() {});
                    }

                    // 4️⃣ Done writing
                    await raf.close();
                    // print("✅ File written successfully!");
                    // print("📁 Final file path: $filePath");

                    // 5️⃣ Close dialog
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      // print("🪟 Dialog closed after download");
                    }

                    // 6️⃣ Open installer
                    // print("📲 Launching APK installer…");
                    await OpenFilex.open(filePath);
                    // print("🎉 Installer launched successfully!");
                  } catch (e, _) {
                    // print("❌ ERROR during update download: $e");
                    // print("🪵 STACKTRACE:");
                    // print(st);

                    if (context.mounted) {
                      showMessageSnackbar(
                          context: context,
                          type: SnackBarType.error,
                          message: 'Download Failed');
                    }
                  }
                }

                return SizedBox(
                  width: context.sizeOfWidth,
                  child: SpacedColumn(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: ColorBgIconHeader(
                          label: 'Update Available',
                          icon: Icons.system_update_alt,
                          color: appColors.cS(context).primary,
                        ),
                      ),
                      Text(
                        '$currentVersion → $latestVersion',
                        style: TextStyles.h6Bold(context)
                            ?.copyWith(color: appColors.cS(context).primary),
                      ),
                      Text(
                        'Update to the latest version for improvements and fixes.',
                        style: TextStyles.h10Gray(context),
                        textAlign: TextAlign.center,
                      ),
                      gapH16,
                      if (!isDownloading)
                        ButtonX.primaryButton(
                          context: context,
                          label: 'Update Now',
                          icon: Icons.system_update_alt,
                          backgroundColor: appColors.cS(context).primary,
                          onPressed: startDownload,
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Text(
                                'Downloading… ${(progress * 100).toStringAsFixed(0)}%',
                                style: TextStyles.h9(context),
                              ),
                              gapH8,
                              LinearProgressIndicator(value: progress),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
    }
  } catch (e) {
    debugPrint('checkAppUpdate error: $e');
  }
}

/// Compare versions: returns true if latestVersion > currentVersion
bool _isVersionGreater(String latest, String current) {
  final latestParts =
      latest.replaceFirst('v', '').split('.').map(int.parse).toList();
  final currentParts =
      current.replaceFirst('v', '').split('.').map(int.parse).toList();

  for (var i = 0; i < latestParts.length; i++) {
    if (i >= currentParts.length) return true;
    if (latestParts[i] > currentParts[i]) return true;
    if (latestParts[i] < currentParts[i]) return false;
  }

  return latestParts.length > currentParts.length;
}

Future<void> cleanOldApk() async {
  final dir = await getExternalStorageDirectory();
  final filePath = '${dir!.path}/${AppEnv.appName.toLowerCase()}_update.apk';
  final file = File(filePath);

  if (await file.exists()) {
    await file.delete();
  }
}
