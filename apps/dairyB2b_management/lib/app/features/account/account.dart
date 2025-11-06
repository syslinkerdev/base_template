import 'package:core/core.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_assets/app_images.dart';

class Account extends ConsumerWidget {
  const Account({super.key});
  static const double topWidgetHeight = 80.0;
  static const double avatarRadius = 53.0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorX = appColors.cS(context).primaryContainer;
    final uId = ref.watch(appStateXProvider).uId;
    final userFetcher = ref.watch(fetchUserProvider(documentId: uId));
    return userFetcher.when(
      data: (user) {
        // log('${user?.toDocument()}');
        if (user == null) {
          return const Center(child: Text('Ghost'));
        }
        // ✅ Cache user globally
        GlobalCacheService.instance.setUser(user);
        return ScaffoldX(
          appBarBackgroundColor: colorX,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(decoration: BoxDecoration(color: colorX)),
              Positioned.fill(
                top: kToolbarHeight + 24,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: appColors.ms.white(context),
                    border: Border.all(color: appColors.ms.white(context)),
                  ),
                  child: SingleChildScrollView(
                    child: SpacedColumn(
                      defaultHeight: 8,
                      children: [
                        const SizedBox(height: avatarRadius),
                        ContainerX(
                          margin: EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.badge,
                                      color: ColorX.instance.ms.black(context),
                                      size: 24.0),
                                  gapW12,
                                  Text(
                                    'Profile Details',
                                    style: TextStyles.h8Gray(context)
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              gapH4,
                              SpacedColumn(
                                children: [
                                  MetaRow(
                                      label: 'Name :',
                                      value:
                                          '${user.firstName} ${user.lastName}'),
                                  MetaRow(
                                      label: 'Phone No. :',
                                      value:
                                          '${user.phoneNumber.substring(0, 3)} ${user.phoneNumber.substring(3)}'),
                                  MetaRow(
                                      label: 'Role :',
                                      value:
                                          user.role?.name.captilizeName ?? ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ButtonX.containerButton(
                          context: context,
                          label: 'Settings',
                          icon: Icons.settings,
                          labelColor: appColors.ms.textBlack50(context),
                          iconFirst: true,
                          loading: false,
                          noAsyncLoading: true,
                          onPressed: () async => await AppRoute.settings
                              .push(context, extra: user),
                        ),
                        ButtonX.containerButton(
                          context: context,
                          label: 'Open ${AppEnv.companyName} Orders',
                          flex: MainAxisAlignment.spaceBetween,
                          iconAsWidget: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: appColors.sc.nero),
                            child: sysImages.MOlogo.toWidget(
                                width: context.sizeOfWidth * 0.1),
                          ),
                          labelColor: appColors.ms.textBlack50(context),
                          iconFirst: false,
                          loading: false,
                          noAsyncLoading: true,
                          onPressed: () async {
                            try {
                              await AppLauncherService.openOrdersApp();
                            } catch (e) {
                              if (context.mounted) {
                                showMessageSnackbar(
                                  context: context,
                                  message: e.toString(),
                                  maxLines: 2,
                                );
                              }
                            }
                          },
                        ),
                        ContainerX(
                          margin: EdgeInsets.only(bottom: 8),
                          height: 52,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppEnv.companyName,
                                style: TextStyles.h8Gray(context)
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              AppVersionText(
                                textStyle: TextStyles.h7Bold(context)?.copyWith(
                                    fontSize: context.sizeOfHeight * 0.024),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: topWidgetHeight - avatarRadius,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: avatarRadius * 2,
                    height: avatarRadius * 2,
                    decoration: BoxDecoration(
                      color: appColors.ms.white(context),
                      borderRadius:
                          BorderRadius.all(Radius.circular(avatarRadius)),
                      border: Border.all(
                          color: appColors.ms.white(context), width: 6),
                    ),
                    child: CircularImageAvatar(image: user.avatar),
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) =>
          ErrorScreen(error: error, onRetry: () => refresh(ref: ref, uId: uId)),
      loading: () => const LoadingScreen(),
    );
  }

  static Future<void> refresh({
    required WidgetRef ref,
    required String uId,
  }) async {
    final refreshedUser =
        await ref.refresh(fetchUserProvider(documentId: uId).future);

    if (refreshedUser != null) {
      GlobalCacheService.instance.setUser(refreshedUser);
    }
  }
}
