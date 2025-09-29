import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';
import '../../../userRole/role_provider.dart';
import '../../../userRole/user_role.dart';

class DashboardCard extends StatelessWidget {
  final String? header;
  final String? price;
  final String? duration;
  final bool? hideDetailText;
  final double? width;
  final double? height;
  final String? percentage;
  const DashboardCard({super.key, this.height, this.price, this.header, this.percentage, this.width, this.duration, this.hideDetailText});

  @override
  Widget build(BuildContext context) {
    final role = context.read<RoleProvider>().role;
    return Container(
      padding: EdgeInsets.all(getHeightRatio() * 16),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha:0.05),
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: header??'Profile Views',
            fontSize: sizes?.fontSize14,
            fontWeight: FontWeight.w500,
            color: AppColors.primarySlateColor,
          ),
          SizedBox(height: getHeightRatio() * 6),
          CustomText(
            text: price??'932',
            fontSize: sizes?.fontSize20,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
          if(!(role == UserRole.restaurant))
          SizedBox(height: getHeightRatio() * 6),
          if(!(role == UserRole.restaurant))
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: percentage??'+16%',
                fontSize: sizes?.fontSize12,
                fontWeight: FontWeight.w500,
                color: AppColors.wellnessPrimaryColor,
              ),
              SizedBox(width: getWidth() * 0.02),
              CustomText(
                text: 'vs ${duration??"Last Week"}',
                fontSize: sizes?.fontSize12,
                fontWeight: FontWeight.w400,
                color: AppColors.primarySlateColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MostChosenDishCard extends StatelessWidget {
  final String? header;
  final String? price;
  final String? duration;
  final String? percentage;
  const MostChosenDishCard({super.key, this.price, this.header, this.percentage, this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getHeightRatio() * 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.05),
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: header??'Profile Views',
                fontSize: sizes?.fontSize14,
                fontWeight: FontWeight.w500,
                color: AppColors.primarySlateColor,
              ),
              SizedBox(height: getHeightRatio() * 6),
              CustomText(
                text: price??'932',
                fontSize: sizes?.fontSize20,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              SizedBox(height: getHeightRatio() * 6),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Chosen ',
                      style: TextStyle(
                        fontSize: sizes?.fontSize12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primarySlateColor,
                        fontFamily: Assets.onsetRegular,
                      ),
                    ),
                    TextSpan(
                      text: percentage ?? '88 ',
                      style: TextStyle(
                        fontSize: sizes?.fontSize12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.wellnessPrimaryColor,
                        fontFamily: Assets.onsetRegular,
                      ),
                    ),
                    TextSpan(
                      text: 'times this week',
                      style: TextStyle(
                        fontSize: sizes?.fontSize12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primarySlateColor,
                        fontFamily: Assets.onsetRegular,
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}
