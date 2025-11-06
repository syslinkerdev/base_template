import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/widgets/slider_holder.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/discount_section_view.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/widgets/discount_section_card.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_section_holder.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_section_builder.dart';
import 'package:system_assets/app_images.dart';

class DiscountSections extends HookConsumerWidget {
  const DiscountSections({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorX = appColors.cS(context).surfaceTint;
    final disSectionsPro = ref.watch(discountSectionsStreamXProvider);
    ref.listen(discountSectionBuilderProvider,
        (_, next) => next.showAlertDialogOnError(context));
    return ScaffoldX(
      title: 'Section Builder',
      wantLeading: true,
      body: disSectionsPro.when(
        data: (disSections) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              defaultHeight: 12,
              children: [
                ContainerX(
                  padding: const EdgeInsets.all(7),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  child: SizedBox(
                    height: context.sizeOfHeight * 0.18,
                    child: Stack(
                      clipBehavior: Clip.none, // allows overflow
                      children: [
                        Positioned(
                          bottom: -8,
                          right: -8,
                          child: sysImages.sectionBuilder
                              .toWidget(height: context.sizeOfHeight * 0.195),
                        ),
                        Positioned.fill(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  colors: [
                                    Color(0xFF7C4DFF), // Deep Purple
                                    Color(0xFFFF4081), // Pink
                                    Color(0xFF00BFA5), // Teal Accent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.centerRight,
                                ).createShader(Rect.fromLTWH(
                                        0, 0, bounds.width, bounds.height)),
                                blendMode: BlendMode.srcIn,
                                child: Text(
                                  'Discount Sections (${disSections.length})',
                                  style: TextStyles.h8Bold(context)?.copyWith(
                                    fontSize: context.sizeOfHeight * 0.023,
                                  ),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'Group similar offers\nto apply them ',
                                  style: TextStyles.h9Bold(context)?.copyWith(
                                    color: appColors.ms.textBlack50(context),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'quickly.',
                                      style: TextStyles.h9Bold(context)
                                          ?.copyWith(color: Color(0xFF7C4DFF)),
                                    ),
                                  ],
                                ),
                              ),
                              gapH8,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ButtonX.containerButton(
                  context: context,
                  label: 'Create New Discounts Section',
                  labelColor: colorX,
                  labelStyle:
                      TextStyles.h8Bold(context)?.copyWith(fontSize: 18),
                  icon: Icons.add_rounded,
                  iconSize: 32,
                  borderRadius: 12,
                  buttonHeight: 58,
                  noAsyncLoading: true,
                  flex: MainAxisAlignment.spaceBetween,
                  onPressed: () async =>
                      await DialogsX.showCustomDialog<String?>(context,
                              content: CreateDisSection())
                          .then(
                    (disSecName) async {
                      if (disSecName != null) {
                        await ref
                            .watch(discountSectionHolderProvider.notifier)
                            .createDisSection(disSecName);
                        AppRoute.discountSectionBuilderPage.push(context);
                      } else {
                        return;
                      }
                    },
                  ),
                ),
                ButtonX.containerButton(
                  context: context,
                  label: 'Generate Discounts Section',
                  labelColor: colorX,
                  labelStyle:
                      TextStyles.h8Bold(context)?.copyWith(fontSize: 18),
                  icon: Icons.add_rounded,
                  iconSize: 32,
                  borderRadius: 12,
                  buttonHeight: 58,
                  noAsyncLoading: true,
                  flex: MainAxisAlignment.spaceBetween,
                  onPressed: () async => await DialogsX.showCustomDialog<int?>(
                          context,
                          content: GenerateDisSection())
                      .then(
                    (percentage) async {
                      if (percentage != null) {
                        showMessageSnackbar(
                            context: context,
                            message: 'Generating Discounts Section...',
                            type: SnackBarType.loading,
                            duration: Duration(minutes: 1));
                        await ref
                            .read(discountSectionBuilderProvider.notifier)
                            .generateDisSectionAndPublish(percentage)
                            .then(
                          (disSecId) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            if (disSecId != null) {
                              AppRoute.discountSectionView.push(context,
                                  extra: DiscountSectionViewArgs(
                                      initialDisSectionId: disSecId));
                              showMessageSnackbar(
                                  context: context,
                                  message:
                                      'Successfully Generated Discounts Section',
                                  type: SnackBarType.success,
                                  maxLines: 2);
                            }
                          },
                        );
                      } else {
                        return;
                      }
                    },
                  ),
                ),
                if (disSections.isEmpty) ...[
                  ContainerX(
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.discount,
                              size: context.sizeOfHeight * 0.1,
                              color: appColors.sc.grey650),
                          gapH20,
                          Text(
                            'No Discount Section Created.',
                            style: TextStyles.h8(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                ] else ...[
                  SimpleHeading(
                      label: 'Discount Sections (${disSections.length})'),
                  DynamicList<DiscountSection>(
                    physics: NeverScrollableScrollPhysics(),
                    items: disSections,
                    onSelect: (disSection) => AppRoute.discountSectionView.push(
                        context,
                        extra: DiscountSectionViewArgs(
                            initialDisSectionId: disSection.id)),
                    itemBuilder: (context, disSection, isSelected) =>
                        DiscountSectionCard(ref: ref, disSection: disSection),
                  ),
                ],
              ],
            ),
          );
        },
        error: (error, stackTrace) => ErrorScreen(error: error, onRetry: () {}),
        loading: () => _buildShimmerLoading(context),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliers = [0.2, 0.07, 0.07, 0.03, 0.2, 0.2, 0.2, 0.2];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SpacedColumn(
        children: List.generate(heightMultipliers.length, (i) {
          return ShimmerX(
            width: context.sizeOfWidth,
            height: context.sizeOfHeight * heightMultipliers[i],
          );
        }),
      ),
    );
  }
}

class CreateDisSection extends HookConsumerWidget {
  const CreateDisSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameCtrl = useTextEditingController();

    final creationIcon = Icons.brush;
    return SizedBox(
      width: context.sizeOfWidth,
      child: SpacedColumn(
        mainAxisSize: MainAxisSize.max,
        children: [
          ColorBgIconHeader(
            label: 'Section Create',
            icon: creationIcon,
            color: Colors.lightGreen,
            trailing: InkWell(
              onTap: () => context.pop(),
              child: CircleAvatar(
                radius: 14,
                backgroundColor:
                    appColors.ms.whiteSwNero(context).withValues(alpha: 0.7),
                child: Icon(Icons.close_rounded,
                    size: 20, color: appColors.ms.neroSwWhite(context)),
              ),
            ),
          ),
          AppTextField(
              controller: nameCtrl,
              hintText: 'Discount Section Name',
              isMandatory: true,
              title: 'Name'),
          gapH12,
          ButtonX.primaryButton(
            context: context,
            label: 'Create',
            icon: creationIcon,
            backgroundColor: Colors.lightGreen,
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                context.pop(nameCtrl.text.toTitleCase);
              } else {
                return;
              }
            },
          )
        ],
      ),
    );
  }
}

class GenerateDisSection extends HookConsumerWidget {
  const GenerateDisSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generateIcon = Icons.auto_awesome;
    final percentage = useState<double>(0);
    return SizedBox(
      width: context.sizeOfWidth,
      child: SpacedColumn(
        mainAxisSize: MainAxisSize.max,
        children: [
          ColorBgIconHeader(
            label: 'Section Generate',
            icon: generateIcon,
            color: Colors.deepOrangeAccent,
            trailing: InkWell(
              onTap: () => context.pop(),
              child: CircleAvatar(
                radius: 14,
                backgroundColor:
                    appColors.ms.whiteSwNero(context).withValues(alpha: 0.7),
                child: Icon(Icons.close_rounded,
                    size: 20, color: appColors.ms.neroSwWhite(context)),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: CaptionText(title: 'Percentage', isRequired: true)),
          gapH4,
          SliderHolder(
            leading: Text(
              '%',
              textAlign: TextAlign.end,
              style: TextStyles.h9Gray(context),
            ),
            slider: Slider(
              padding: EdgeInsets.symmetric(horizontal: 14),
              value: percentage.value, // should be between 0 and 100
              min: 0,
              max: 100,
              divisions: 20, // steps of 5%
              label: '${percentage.value.round()}%',
              onChanged: (newValue) {
                // Snap to nearest 5
                double step = 5;
                double roundedValue = (newValue / step).round() * step;

                percentage.value = roundedValue;
                // Optional: show toast at 100%
                if (roundedValue == 100) {
                  showMessageSnackbar(
                    context: context,
                    message: 'Max percentage (100%) reached to Generate',
                    maxLines: 2,
                  );
                }
              },
            ),
            trailing: Text(
              percentage.value.toStringAsFixed(1),
              textAlign: TextAlign.center,
              style: TextStyles.h9(context),
            ),
          ),
          if (percentage.value.isNotNull)
            Text('${percentage.value}% of the Global Discounts Section',
                style: TextStyles.h10Gray(context)),
          gapH12,
          ButtonX.primaryButton(
            context: context,
            label: 'Generate',
            icon: generateIcon,
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () {
              if (percentage.value.isNotNull) {
                context.pop(percentage.value.toInt());
              } else {
                return;
              }
            },
          )
        ],
      ),
    );
  }
}
