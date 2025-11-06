import 'package:flutter/material.dart';
import 'package:core/core.dart';

class KnowYourColors extends StatelessWidget {
  const KnowYourColors({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cS = CFunS().cS(context);
    return ScaffoldX(
      title: 'Know Your Colors',
      appBarActions: [Icon(Icons.color_lens), gapW12],
      wantLeading: true,
      titleCenter: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            baseContainer(context, cS.error, 'Error Color'),
            baseContainer(context, cS.errorContainer, 'errorContainer'),
            baseContainer(context, cS.inversePrimary, 'inversePrimary'),
            baseContainer(context, cS.inverseSurface, 'inverseSurface'),
            baseContainer(context, cS.onError, 'onError'),
            baseContainer(context, cS.onErrorContainer, 'onErrorContainer'),
            baseContainer(context, cS.onInverseSurface, 'onInverseSurface'),
            baseContainer(context, cS.onPrimary, 'onPrimary'),
            baseContainer(context, cS.onPrimaryContainer, 'onPrimaryContainer'),
            baseContainer(context, cS.onPrimaryFixed, 'onPrimaryFixed'),
            baseContainer(
                context, cS.onPrimaryFixedVariant, 'onPrimaryFixedVariant'),
            baseContainer(context, cS.onSecondary, 'onSecondary'),
            baseContainer(
                context, cS.onSecondaryContainer, 'onSecondaryContainer'),
            baseContainer(context, cS.onSecondaryFixed, 'onSecondaryFixed'),
            baseContainer(
                context, cS.onSecondaryFixedVariant, 'onSecondaryFixedVariant'),
            baseContainer(context, cS.onSurface, 'onSurface'),
            baseContainer(context, cS.onSurfaceVariant, 'onSurfaceVariant'),
            baseContainer(context, cS.onTertiary, 'onTertiary'),
            baseContainer(
                context, cS.onTertiaryContainer, 'onTertiaryContainer'),
            baseContainer(context, cS.onTertiaryFixed, 'onTertiaryFixed'),
            baseContainer(
                context, cS.onTertiaryFixedVariant, 'onTertiaryFixedVariant'),
            baseContainer(context, cS.outline, 'outline'),
            baseContainer(context, cS.outlineVariant, 'outlineVariant'),
            baseContainer(context, cS.primary, 'primary'),
            baseContainer(context, cS.primaryContainer, 'primaryContainer'),
            baseContainer(context, cS.primaryFixed, 'primaryFixed'),
            baseContainer(context, cS.primaryFixedDim, 'primaryFixedDim'),
            baseContainer(context, cS.scrim, 'scrim'),
            baseContainer(context, cS.secondary, 'secondary'),
            baseContainer(context, cS.secondaryContainer, 'secondaryContainer'),
            baseContainer(context, cS.secondaryFixed, 'onSecondaryFixed'),
            baseContainer(context, cS.secondaryFixedDim, 'secondaryFixedDim'),
            baseContainer(context, cS.shadow, 'shadow'),
            baseContainer(context, cS.surface, 'surface'),
            baseContainer(context, cS.surfaceBright, 'surfaceBright'),
            baseContainer(context, cS.surfaceContainer, 'surfaceContainer'),
            baseContainer(
                context, cS.surfaceContainerHigh, 'surfaceContainerHigh'),
            baseContainer(
                context, cS.surfaceContainerHighest, 'surfaceContainerHighest'),
            baseContainer(
                context, cS.surfaceContainerLow, 'surfaceContainerLow'),
            baseContainer(
                context, cS.surfaceContainerLowest, 'surfaceContainerLowest'),
            baseContainer(context, cS.surfaceDim, 'surfaceDim'),
            baseContainer(context, cS.surfaceTint, 'surfaceTint'),
            baseContainer(context, cS.tertiary, 'tertiary'),
            baseContainer(context, cS.tertiaryContainer, 'tertiaryContainer'),
            baseContainer(context, cS.tertiaryFixed, 'tertiaryFixed'),
            baseContainer(context, cS.tertiaryFixedDim, 'tertiaryFixedDim'),
            baseContainer(context, cS.surface, 'background'),
            baseContainer(context, cS.onSurface, 'onBackground'),
            baseContainer(
                context, cS.surfaceContainerHighest, 'surfaceVariant'),
            ContainerX(
                child: SizedBox(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
            )),
            baseContainer(
                context, ColorX.instance.shad.e10(context), 'shade10'),
            baseContainer(
                context, ColorX.instance.shad.e20(context), 'shade20'),
            baseContainer(
                context, ColorX.instance.shad.e30(context), 'shade30'),
            baseContainer(
                context, ColorX.instance.shad.e40(context), 'shade40'),
            baseContainer(
                context, ColorX.instance.shad.e50(context), 'shade50'),
            baseContainer(
                context, ColorX.instance.shad.e60(context), 'shade60'),
            baseContainer(
                context, ColorX.instance.shad.eBright(context), 'shadeBright'),
            gapH12,
            baseContainer(
                context, ColorX.instance.shad.eSw2060(context), 'shadeSw2060'),
          ],
        ),
      ),
    );
  }

  Container baseContainer(BuildContext context, Color color, String title) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      color: color,
      child: Center(
        child: Text(title),
      ),
    );
  }
}
