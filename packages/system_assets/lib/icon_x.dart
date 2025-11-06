import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as p;

class IconX {
  final String path;
  final String? package;

  const IconX(this.path, {this.package});

  Widget toWidget({
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    final extension = p.extension(path).toLowerCase();

    if (extension == '.svg') {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        color: color,
        fit: fit,
        package: package,
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      color: color,
      fit: fit,
      package: package,
    );
  }

  // Empty Data illustration
  // static const emptySearch = IconX('assets/images/empty_search.svg');
  // static const info = IconX('assets/images/info.png');
  // This like we have to get urls from git and show to users || or we have to add this image in user assert
  // static const exUrl = IconX('https://raw.githubusercontent.com/bharathram444/core/refs/heads/main/image/dark.png');
}
