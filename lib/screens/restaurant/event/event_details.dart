import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';
import 'eventWidgets/delete_event.dart';
import 'eventWidgets/event_info.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key,});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final isDraft = extra?["isDraft"]??false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: getHeight() * .33,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://i.pinimg.com/originals/49/7e/e8/497ee84d017ffca00fd23bf78d3ebe39.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: getHeight() * .06,
                  left: 16,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white30,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "1/5",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            EventInfoSection(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth() * .05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getHeight() * .01),
                  Divider(color: AppColors.greyColor),
                  SizedBox(height: getHeight() * .02),
                  // Row 1: Title + Show All
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Participants",
                        fontSize: sizes?.fontSize16,
                        fontFamily: Assets.onsetSemiBold,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(right: getWidth() * 0.01), // <--- Prevents extra height
                          minimumSize: Size(0, 0),  // <--- Keeps button compact
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: CustomText(
                          text: "Show All",
                          fontSize: sizes?.fontSize14,
                          fontFamily: Assets.onsetMedium,
                          color: AppColors.getPrimaryColorFromContext(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight() * .015),

                // Row 2: Avatars + User Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatars
                      SizedBox(
                        height: getHeight() * .05,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            _buildAvatar('https://randomuser.me/api/portraits/women/65.jpg'),
                            Positioned(
                              left: getWidth() * .05,
                              child: _buildAvatar('https://randomuser.me/api/portraits/women/60.jpg'),
                            ),
                            Positioned(
                              left: getWidth() * .10,
                              child: _buildAvatar('https://randomuser.me/api/portraits/men/62.jpg'),
                            ),
                            Positioned(
                              left: getWidth() * .15,
                              child: _buildAvatarCircle('+10'),
                            ),
                          ],
                        ),
                      ),

                      // User count aligned with Show All
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.peopleIcon,
                            height: getHeight() * .022,
                          ),
                          SizedBox(width: getWidth() * .01),
                          CustomText(
                            text: "10/120",
                            fontSize: sizes?.fontSize12,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: getHeight() * .01),
                  Divider(color: AppColors.greyColor),
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
                  SizedBox(height: getHeight() * .01),
                  Divider(color: AppColors.greyColor),
                  SizedBox(height: getHeight() * .02),
                  CustomText(
                    text: "Location",
                    fontSize: sizes?.fontSize16,
                    fontFamily: Assets.onsetSemiBold,
                  ),
                  SizedBox(height: getHeight() * 0.015), // small vertical gap
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        Assets.locationSvg,
                        height: getHeight() * 0.022,
                        width: getHeight() * 0.022,
                      ),
                      SizedBox(width: getWidth() * 0.02), // horizontal gap
                      Expanded(
                        child: CustomText(
                          text: "Av. Gustave Eiffel, 75007 Paris, France",
                          fontSize: sizes?.fontSize12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight() * 0.008), // small vertical gap
                  Image.asset(Assets.mapImage, height: getHeight() * .2),
                  SizedBox(height: getHeight() * .01),
                  Divider(color: AppColors.greyColor),
                  SizedBox(height: getHeight() * .02),
                  CustomText(
                    text: "Socia Links",
                    fontSize: sizes?.fontSize16,
                    fontFamily: Assets.onsetSemiBold,
                  ),
                  SizedBox(height: getHeight() * .015),
                  Row(
                    children: [
                      SvgPicture.asset(Assets.webCircleIcon),
                      SizedBox(width: getWidth() * .04),
                      SvgPicture.asset(Assets.instaCircleIcon),
                      SizedBox(width: getWidth() * .04),
                      SvgPicture.asset(Assets.xCircleIcon),
                      SizedBox(width: getWidth() * .04),
                      SvgPicture.asset(Assets.facebookCircleIcon),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight() * .02),
            isDraft
                ? Padding(
              padding: EdgeInsets.symmetric(
                vertical: getHeight() * .02,
                horizontal: getWidth() * .05,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: getHeight() * .055,
                      backgroundColor: Colors.transparent,
                      buttonText: "Delete",
                      textColor: Colors.red,
                      borderColor: Colors.red,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteEventDialog();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      height: getHeight() * .055,
                      buttonText: "Edit",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            )
                : const SizedBox.shrink(),
            SizedBox(height: getHeight() * .02),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.white,
      child: CircleAvatar(radius: 14, backgroundImage: NetworkImage(imageUrl)),
    );
  }

  Widget _buildAvatarCircle(String text) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: Colors.grey.shade400,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
