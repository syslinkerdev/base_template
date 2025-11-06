import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/account/widgets/basic_account_details_tile.dart';
import 'package:dairyB2b_orders/app/features/account/widgets/discounts_tile.dart';
import 'package:dairyB2b_orders/app/features/account/widgets/since_tile.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';
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
          appBarActions: [
            IconButton(
              color: appColors.sc.mystic,
              icon: const Icon(Icons.settings),
              onPressed: () => AppRoute.settings.push(context, extra: user),
              style: OutlinedButton.styleFrom(
                  backgroundColor: appColors.ms.transparent80(context)),
            ),
            gapW8,
          ],
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
                  child: Column(
                    children: [
                      const SizedBox(height: avatarRadius),
                      BasicAccountDetailsTile(
                        fullName: "${user.firstName} ${user.lastName}",
                        phoneNumber: user.phoneNumber,
                        editProfileOnPress: () =>
                            AppRoute.editAccount.push(context, extra: {
                          'avatar': user.avatar,
                          'fName': user.firstName,
                          'lName': user.lastName,
                          'phone': user.phoneNumber,
                          'hPin': user.hashedPassword,
                          'uid': user.uid,
                          'role': user.role
                        }),
                      ),
                      DiscountsTile(
                          disSection:
                              user.disSection ?? DiscountSection.empty()),
                      SinceTile(createdDate: user.createdAt),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: ButtonX.containerButton(
                          context: context,
                          label: 'Your Admin',
                          labelColor: appColors.ms.textBlack80(context),
                          flex: MainAxisAlignment.spaceBetween,
                          icon: Icons.arrow_forward_ios_rounded,
                          iconSize: context.sizeOfWidth * 0.05,
                          noAsyncLoading: true,
                          onPressed: () => AppRoute.yourAdmin
                              .push(context, extra: user.superuserUid),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: ButtonX.containerButton(
                          context: context,
                          label: 'About this App',
                          labelColor: appColors.ms.textBlack80(context),
                          flex: MainAxisAlignment.spaceBetween,
                          icon: Icons.arrow_forward_ios_rounded,
                          iconSize: context.sizeOfWidth * 0.05,
                          noAsyncLoading: true,
                          onPressed: () => AppRoute.aboutApp.push(context),
                        ),
                      ),
                      ContainerX(
                          margin: EdgeInsets.only(bottom: 8),
                          height: context.sizeOfHeight * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppEnv.companyName,
                                style: TextStyles.h8Bold(context),
                              ),
                              AppVersionText(
                                textStyle: TextStyles.h7Bold(context)?.copyWith(
                                    fontSize: context.sizeOfHeight * 0.024),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: context.sizeOfWidth * 0.04,
                top: topWidgetHeight - avatarRadius,
                child: Container(
                  width: avatarRadius * 2,
                  height: avatarRadius * 2,
                  decoration: BoxDecoration(
                      color: appColors.ms.white(context),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(avatarRadius)),
                      border: Border.all(
                          color: appColors.ms.white(context), width: 6)),
                  child: CircularImageAvatar(image: user.avatar),
                ),
              ),
              if (user.role != Role.client) ...[
                Positioned(
                  right: context.sizeOfWidth * 0.06,
                  top: (topWidgetHeight - avatarRadius) + 34,
                  child: InkWell(
                    onTap: () async {
                      try {
                        await AppLauncherService.openManagementApp();
                      } catch (e) {
                        //print(e);
                        if (context.mounted) {
                          showMessageSnackbar(
                              context: context,
                              message: e.toString(),
                              maxLines: 2);
                        }
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StrokeText(
                          text: "Nav",
                          fontSize: 21,
                          strokeWidth: 4,
                          strokeColor: appColors.ms.white(context),
                          fillColor: appColors.ms.textBlack80(context),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          wordSpacing: 2,
                          height: 1.2,
                        ),
                        gapW8,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: appColors.sc.nero),
                          child: sysImages.MMlogo.toWidget(
                              width: context.sizeOfWidth * 0.1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
