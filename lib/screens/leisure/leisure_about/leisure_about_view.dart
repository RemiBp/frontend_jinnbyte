import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';

class LeisureAboutView extends StatefulWidget {
  const LeisureAboutView({super.key});

  @override
  State<LeisureAboutView> createState() => _LeisureAboutViewState();
}

class _LeisureAboutViewState extends State<LeisureAboutView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: "About",
              fontSize: sizes?.fontSize16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * .01),
            ReadMoreText(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi viverra mauris sagittis dis. Sed quis enim nulla arcu turpis in.",
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimCollapsedText: 'Read More',
              trimExpandedText: 'See Less',
              style: TextStyle(
                fontSize: sizes?.fontSize16,
                color: AppColors.blackColor,
              ),
              moreStyle: TextStyle(
                fontSize: sizes?.fontSize14,
                color: AppColors.getPrimaryColorFromContext(context),
                fontFamily: Assets.onsetMedium,
              ),
            ),
            Divider(color: AppColors.greyBordersColor,height: getHeight() * .03),
            CustomText(
              text: "Location",
              fontSize: sizes?.fontSize16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * .01),
            CustomText(
              text: " Av. Gustave Eiffel, 75007 Paris, France",
              fontSize: sizes?.fontSize12,
            ),
            Image.asset(Assets.mapImage, height: getHeight() * .2),
            SizedBox(height: getHeight() * .01),
            Divider(color: AppColors.greyColor),
            CustomText(
              text: "Socia Links",
              fontSize: sizes?.fontSize16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * .01),
            Row(
              children: [
                CircleAvatar(
                    radius: getHeight() * .03,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context).withAlpha(20),
                    child: SvgPicture.asset(
                      Assets.websiteIcon,
                      height: getHeight() * .03,
                      color: AppColors.getPrimaryColorFromContext(context),
                    )
                  // : null,
                ),
                SizedBox(width: getWidth() * 0.015),
                CircleAvatar(
                    radius: getHeight() * .03,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context).withAlpha(20),
                    child: SvgPicture.asset(
                      Assets.instagramIcon,
                      height: getHeight() * .03,
                      color: AppColors.getPrimaryColorFromContext(context),
                    )
                  // : null,
                ),
                SizedBox(width: getWidth() * 0.015),
                CircleAvatar(
                    radius: getHeight() * .03,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context).withAlpha(20),
                    child: SvgPicture.asset(
                      Assets.xIcon,
                      height: getHeight() * .03,
                      color: AppColors.getPrimaryColorFromContext(context),
                    )
                  // : null,
                ),
                SizedBox(width: getWidth() * 0.015),
                CircleAvatar(
                    radius: getHeight() * .03,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context).withAlpha(20),
                    child: SvgPicture.asset(
                      Assets.facebookIcon,
                      height: getHeight() * .03,
                      color: AppColors.getPrimaryColorFromContext(context),
                    )
                  // : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
