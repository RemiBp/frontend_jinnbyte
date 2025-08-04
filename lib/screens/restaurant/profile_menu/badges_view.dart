import 'package:choice_app/screens/restaurant/profile_menu/profile_menu_widgets.dart';
import 'package:flutter/material.dart';

import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';

class BadgesView extends StatelessWidget {
  const BadgesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Badge & XP"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getHeight() * 0.02,),
          XPCard(
            title: "First Booking Master",
            subtitle: "Complete your very first booking of any kind",
            xp: "+50XP",
            xpColor: Colors.green,
          ),

          XPCard(
            title: "Choice Creator",
            subtitle: "Create your first choice and start exploring options",
            xp: "+20XP",
            xpColor: Colors.blue,
          ),

          XPCard(
            title: "Review Contributor",
            subtitle: "Share your experience by posting a new review",
            xp: "+10XP",
            xpColor: Colors.blue,
            progress: 3,
            total: 5,
          ),

          SizedBox(height: getHeight() * 0.025),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Achievement Badges",
                  fontSize: sizes?.fontSize16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                  giveLinesAsText: true,
                ),
                CustomText(
                  text: "View More",
                  fontSize: sizes?.fontSize14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.userPrimaryColor,
                  giveLinesAsText: true,
                ),
              ],
            ),
          ),
          SizedBox(height: getHeight() * 0.01),
          _buildBadge(),
        ],
      ),
    );
  }


  Widget _buildBadge() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
      padding: EdgeInsets.symmetric(vertical: getHeight() * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: AppColors.greyBordersColor)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(Assets.badge1, width: getWidth() * 0.15,),
          Image.asset(Assets.badge2, width: getWidth() * 0.15,),
          Image.asset(Assets.badge3, width: getWidth() * 0.15,),
          Image.asset(Assets.badge4, width: getWidth() * 0.15,),
        ],
      ),
    );
  }
}
