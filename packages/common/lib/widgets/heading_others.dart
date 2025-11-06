import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:core/core.dart';

class HeadingLineFade extends StatelessWidget {
  const HeadingLineFade({
    super.key,
    required this.label,
    this.style,
    this.width = 2,
    this.verticalPadding = 10,
    this.gap = gapW4,
  });
  final String label;
  final TextStyle? style;
  final double width;
  final double verticalPadding;
  final SizedBox gap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        children: [
          Text(
            label,
            style: (style ?? TextStyles.h8Bold(context))
                ?.copyWith(wordSpacing: 4, letterSpacing: 3),
          ),
          gap,
          Flexible(
            child: Container(
              height: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    appColors.ms.black80(context),
                    appColors.ms.greyTransparent40(context)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingLineFadeWithLoading extends StatelessWidget {
  const HeadingLineFadeWithLoading({
    super.key,
    required this.label,
    this.isLoading = false,
  });

  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyles.h8Bold(context)
                ?.copyWith(wordSpacing: 4, letterSpacing: 3),
          ),
          gapW4,
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isLoading
                  ? const LinearProgressIndicator(minHeight: 2)
                  : Container(
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            appColors.ms.black80(context),
                            appColors.ms.greyTransparent40(context)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleHeading extends StatelessWidget {
  const SimpleHeading({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyles.h8Bold(context),
          ),
          gapW4,
          Flexible(
            child: Container(
              height: 1.4,
              color: appColors.ms.greyTransparent80(context),
            ),
          ),
        ],
      ),
    );
  }
}

class LabelInfo extends StatelessWidget {
  const LabelInfo({
    super.key,
    required this.label,
    required this.info,
  });
  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: context.sizeOfWidth * 0.25,
            child: Text(label, style: TextStyles.h10Gray(context))),
        SizedBox(width: context.sizeOfWidth * 0.06),
        Flexible(child: Text(info, style: TextStyles.h10(context)))
      ],
    );
  }
}

class ColorBgIcon extends StatelessWidget {
  const ColorBgIcon(
      {super.key,
      required this.icon,
      this.color = Colors.deepPurple,
      this.size = 40.0});
  final IconData icon;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: color!.withValues(alpha: 0.3), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: size * 0.6),
    );
  }
}

class ColorBgIconHeader extends StatelessWidget {
  const ColorBgIconHeader(
      {super.key,
      required this.label,
      required this.icon,
      required this.color,
      this.trailing});

  final String label;
  final IconData icon;
  final Color color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColorBgIcon(size: 26.0, color: color, icon: icon),
        gapW8,
        Text(label, style: TextStyles.h10Bold(context)),
        if (trailing != null) ...[const Spacer(), trailing!],
      ],
    );
  }
}

class DashDivider extends StatelessWidget {
  final double dashWidth;
  final double dashHeight;
  final Color? color;
  final double gap;

  const DashDivider({
    super.key,
    this.dashWidth = 6.0,
    this.dashHeight = 1.5,
    this.color,
    this.gap = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final colorX = color ?? appColors.sc.grey;
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / (dashWidth + gap)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: dashHeight,
              color: colorX,
            );
          }),
        );
      },
    );
  }
}

class PriceTag extends StatelessWidget {
  const PriceTag({
    super.key,
    required this.price,
    this.style,
    this.cancelStyle = false,
  });

  final double price;
  final TextStyle? style;
  final bool cancelStyle;

  static String formatPrice(double price) {
    final format = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '',
      decimalDigits: 2,
    );
    return format.format(price).trim();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '\u{20B9}${formatPrice(price)}',
      style: cancelStyle
          ? TextStyles.h14Bold(context)?.copyWith(
              fontFamily: 'Roboto',
              decoration: TextDecoration.lineThrough,
              decorationThickness: context.sizeOfHeight * 0.002,
              decorationColor: appColors.ms.textBlack50(context),
              color: appColors.ms.textBlack50(context),
            )
          : (style?.copyWith(
                  fontFamily: 'Roboto', color: appColors.sc.moneyGreen) ??
              TextStyles.h10Bold(context)?.copyWith(
                  fontFamily: 'Roboto', color: appColors.sc.moneyGreen)),
    );
  }
}

class DashedUnderlineText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const DashedUnderlineText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: style),
        CustomPaint(
            size: Size(text.length * 7, 1), painter: DashedLinePainter()),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = appColors.sc.grey
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    double dashWidth = 4, dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GradientSineWaveDivider extends StatelessWidget {
  final double amplitude;
  final int waveCount;
  final List<Color>? gradientColors;

  const GradientSineWaveDivider(
      {super.key,
      this.amplitude = 8.0,
      this.waveCount = 32,
      this.gradientColors});

  @override
  Widget build(BuildContext context) {
    final gradientColorsX =
        gradientColors ?? [appColors.sc.teal, appColors.cS(context).primaryFixedDim];
    return SizedBox(
      width: double.infinity,
      height: amplitude,
      child: CustomPaint(
        painter: _GradientSineWavePainter(
          amplitude: amplitude,
          waveCount: waveCount,
          gradientColors: gradientColorsX,
        ),
      ),
    );
  }
}

class _GradientSineWavePainter extends CustomPainter {
  final double amplitude;
  final int waveCount;
  final List<Color> gradientColors;

  _GradientSineWavePainter({
    required this.amplitude,
    required this.waveCount,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    final double waveWidth = size.width / waveCount;
    path.moveTo(0, size.height / 2);

    for (int i = 0; i < waveCount; i++) {
      double x1 = i * waveWidth + (waveWidth / 2);
      double y1 = (i % 2 == 0)
          ? size.height / 2 + amplitude
          : size.height / 2 - amplitude;
      double x2 = (i + 1) * waveWidth;
      double y2 = size.height / 2;

      path.quadraticBezierTo(x1, y1, x2, y2);
    }

    final Rect gradientRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Gradient gradient = LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    paint.shader = gradient.createShader(gradientRect);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SimpleDivider extends StatelessWidget {
  const SimpleDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(color: appColors.sc.grey, thickness: 1.2);
  }
}

class MetaRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isPrice;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool valueUnderLine;

  const MetaRow(
      {super.key,
      required this.label,
      required this.value,
      this.valueUnderLine = false,
      this.isPrice = false,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.sizeOfWidth * 0.3,
              child: Text(
                label,
                style: TextStyles.h12Bold(context)?.copyWith(
                  fontFamily: isPrice ? 'Roboto' : null,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyles.h12Bold(context)?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontFamily: isPrice ? 'Roboto' : null,
                  decoration: valueUnderLine ? TextDecoration.underline : null,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) ...[
              gapW8,
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  const InfoChip(
      {super.key,
      required this.label,
      required this.value,
      this.isPrice = false,
      this.showDot = true,
      this.highlight = false});
  final String label;
  final String value;
  final bool isPrice;
  final bool showDot;
  final bool highlight;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${showDot ? '• ' : ''}$label : ',
            style: TextStyles.h13Gray(context)?.copyWith(
              color: highlight ? context.colorScheme.primary : null,
            )),
        Text(value,
            style: TextStyles.h14Gray(context)?.copyWith(
              fontFamily: isPrice ? 'Roboto' : null,
              color: highlight ? context.colorScheme.primary : null,
            )),
      ],
    );
  }
}

class StrokeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double strokeWidth;
  final Color strokeColor;
  final Color fillColor;
  final FontWeight fontWeight;
  final double letterSpacing;
  final double wordSpacing;
  final double height;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;

  const StrokeText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.strokeWidth = 2,
    this.strokeColor = Colors.black,
    this.fillColor = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0,
    this.wordSpacing = 0,
    this.height = 1.0,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.visible,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            height: height,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            height: height,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}
