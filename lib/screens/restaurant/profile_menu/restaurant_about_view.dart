import 'package:choice_app/screens/restaurant/profile_menu/profile_menu_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';

class RestaurantAboutView extends StatefulWidget {
  const RestaurantAboutView({super.key});

  @override
  State<RestaurantAboutView> createState() => _RestaurantAboutViewState();
}

class _RestaurantAboutViewState extends State<RestaurantAboutView> {

  final List<Map<String, String>> operatingHours = [
    {'day': 'Monday', 'time': '09:00 AM - 05:00 PM'},
    {'day': 'Tuesday', 'time': '10:00 AM - 06:00 PM'},
    {'day': 'Wednesday', 'time': '11:00 AM - 07:00 PM'},
    {'day': 'Thursday', 'time': '09:30 AM - 05:30 PM'},
    {'day': 'Friday', 'time': '09:00 AM - 04:00 PM'},
    {'day': 'Saturday', 'time': 'Closed'},
    {'day': 'Sunday', 'time': 'Closed'},
  ];


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
              text: "About Event",
              fontSize: sizes?.fontSize16,
              fontFamily: Assets.onsetSemiBold,
            ),
            SizedBox(height: getHeight() * .02),
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
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: "Location",
              fontSize: sizes?.fontSize16,
              fontFamily: Assets.onsetSemiBold,
            ),
            CustomText(
              text: " Av. Gustave Eiffel, 75007 Paris, France",
              fontSize: sizes?.fontSize12,
            ),
            Image.asset(Assets.mapImage, height: getHeight() * .2),
            SizedBox(height: getHeight() * .01),
            Divider(color: AppColors.greyColor),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: "Socia Links",
              fontSize: sizes?.fontSize16,
              fontFamily: Assets.onsetSemiBold,
            ),
            // SizedBox(height: getHeight() * .01),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: operatingHours.length,
              itemBuilder: (context, index) {
                return OperatingHourItem(
                  day: operatingHours[index]["day"]??"",
                  time: operatingHours[index]["time"]??"",
                );
              },
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: "Socia Links",
              fontSize: sizes?.fontSize16,
              fontFamily: Assets.onsetSemiBold,
            ),
            SizedBox(height: getHeight() * .01),
            Row(
              children: [
                SvgPicture.asset(Assets.webCircleIcon),
                SvgPicture.asset(Assets.instaCircleIcon),
                SvgPicture.asset(Assets.xCircleIcon),
                SvgPicture.asset(Assets.facebookCircleIcon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
