import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/responsive/responsive.dart';

Widget getNodatafoundImage(
    BuildContext context, String? image, Color? imageColor) {
  return SvgPicture.asset(
    image!,
    height: (Responsive.isDesktop(context))
        ? 380
        : (Responsive.isTablet(context))
            ? 300
            : 250,
    width: (Responsive.isDesktop(context))
        ? 350
        : (Responsive.isTablet(context))
            ? 300
            : 250,
    color: imageColor,
  );
}
