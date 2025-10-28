import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final bool? isSeen;
  final String? restaurantName;
  const HomeAppBar({super.key, required this.onNotificationTap, this.isSeen, this.restaurantName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: getHeight() * 0.015),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                text: al.dashboard,
                fontSize: sizes?.fontSize18,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                lines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: ()=> onNotificationTap(),
              child: CustomIconButton(svgString: Assets.messagesIcon),
            ),
            GestureDetector(
              onTap: ()=> onNotificationTap(),
              child: isSeen??false?const CustomIconButton(svgString: Assets.notificationIcon)
                    : const CustomIconButton(svgString: Assets.notificationIcon),
            ),
          ],
        ),
      ),
    );
  }
}
