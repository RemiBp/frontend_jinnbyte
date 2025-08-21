import 'package:flutter/cupertino.dart';

import '../appAssets/app_assets.dart';
import '../appColors/colors.dart';
import '../res/res.dart';
import 'icon_svg.dart';

class ShadowIcon extends StatelessWidget {
  final Color? color;
  final String? icon;
  final bool? isPng;
  const ShadowIcon({super.key, this.color, this.icon, this.isPng});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidthRatio() * 40,
      height: getHeightRatio() * 40,
      decoration: BoxDecoration(
          color: (color??AppColors.restaurantPrimaryColor).withAlpha(40),
          shape: BoxShape.circle
      ),
      child: Center(
        child: isPng??false?
        Image.asset(
          icon??Assets.calenderIcon,
          color: color??AppColors.restaurantPrimaryColor,
          width: getWidthRatio() * 18,
          height: getHeightRatio() * 18,
        ):
        SvgIcon(
          icon??Assets.calenderSvg,
          width: getWidthRatio() * 18,
          height: getHeightRatio() * 18,
          color: color??AppColors.restaurantPrimaryColor,
        ),
      ),
    );
  }
}
