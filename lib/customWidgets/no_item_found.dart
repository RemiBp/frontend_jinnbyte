import 'package:flutter/cupertino.dart';
import '../appAssets/app_assets.dart';
import '../appColors/colors.dart';
import '../res/res.dart';
import 'custom_text.dart';

class NoItemFound extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subTitle;
  final EdgeInsets? margin;
  const NoItemFound({
    super.key,
    this.image,
    this.title,
    this.subTitle,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin??EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: getWidthRatio() * 70,
            height:getHeightRatio() * 70,
            decoration: BoxDecoration(
                color: AppColors.getPrimaryColorFromContext(context).withAlpha(40),
                shape: BoxShape.circle
            ),
            child: Center(
              child: Image.asset(
                image??Assets.bookingIcon,
                width: getWidthRatio() * 30,
                height:getHeightRatio() * 30,
                color: AppColors.getPrimaryColorFromContext(context),
              ),
            ),
          ),
          SizedBox(height: getHeight() * 0.03),
          CustomText(
            text: title??"No upcoming booking",
            fontWeight: FontWeight.w600,
            fontSize: sizes?.fontSize18,
          ),
          SizedBox(height: getHeight() * 0.005),
          CustomText(
            text: subTitle??"You have no upcoming booking",
            fontWeight: FontWeight.w500,
            fontSize: sizes?.fontSize16,
            textAlign: TextAlign.center,
            color: AppColors.primarySlateColor,
          ),
          SizedBox(height: getHeight() * 0.15),
        ],
      ),
    );
  }
}
