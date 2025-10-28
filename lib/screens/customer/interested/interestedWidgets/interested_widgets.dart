import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../l18n.dart';
import '../../../../res/res.dart';

class CustomerInterestView extends StatelessWidget {
  const CustomerInterestView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(4, (i) => {
      "title": "Event Name ${i + 1}",
      "datetime": "Aug ${28 + i}, 10:00 AM - 11:00 AM",
      "location": "12 Rue de Rivoli, 75001 Paris, France",
      "image": Assets.restaurantImage,
      "participants": [
        Assets.restaurantImage,
        Assets.wellnessImage,
        Assets.leisureImage,
        Assets.peopleIcon,
      ],
    });

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: getHeight() * 0.02,
      ),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: getHeight() * 0.018),
      itemBuilder: (context, index) {
        final item = items[index];
        return _InterestCard(
          title: item["title"] as String,
          dateTime: item["datetime"] as String,
          location: item["location"] as String,
          imageAsset: item["image"] as String,
          participants: List<String>.from(item["participants"] as List),
        );
      },
    );
  }
}

class _InterestCard extends StatelessWidget {
  final String title;
  final String dateTime;
  final String location;
  final String imageAsset;
  final List<String> participants;

  const _InterestCard({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.imageAsset,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, //  ensures full width
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: EdgeInsets.all(getWidth() * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: image + event details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageAsset,
                    width: getWidth() * 0.25,
                    height: getWidth() * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: getWidth() * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        fontSize: sizes?.fontSize16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                        textOverflow: TextOverflow.ellipsis,
                        lines: 1,
                      ),
                      SizedBox(height: getHeight() * 0.010),

                      // Date row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.calender,
                            height: getHeight() * 0.018,
                            width: getHeight() * 0.018,
                            colorFilter: ColorFilter.mode(AppColors.getPrimaryColorFromContext(context), BlendMode.srcIn),
                          ),
                          SizedBox(width: getWidth() * 0.02),
                          Expanded(
                            child: CustomText(
                              text: dateTime,
                              fontSize: sizes?.fontSize14,
                              color: AppColors.inputHintColor,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis,
                              lines: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: getHeight() * 0.008),

                      // Location row (fixed alignment)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // fixes vertical misalignment
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: getHeight() * 0.005), //  small top padding
                            child: SvgPicture.asset(
                              Assets.locationIcon,
                              height: getHeight() * 0.019,
                              width: getHeight() * 0.019,
                              colorFilter: ColorFilter.mode(AppColors.getPrimaryColorFromContext(context), BlendMode.srcIn),
                            ),

                          ),
                          SizedBox(width: getWidth() * 0.02),
                          Expanded(
                            child: CustomText(
                              text: location,
                              fontSize: sizes?.fontSize14,
                              color: AppColors.inputHintColor,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis,
                              lines: 2,
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: getHeight() * 0.015),

                      // Participants directly under address
                      SizedBox(
                        height: getHeight() * 0.04,
                        child: Stack(
                          children: List.generate(
                            participants.length,
                                (i) => Positioned(
                              left: i * getWidth() * 0.06,
                              child: CircleAvatar(
                                radius: getHeight() * 0.02,
                                backgroundImage: AssetImage(participants[i]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: getHeight() * 0.025),

            // Buttons row at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: al.decline,
                    onTap: () {},
                    height: getHeight() * 0.055,
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.blackColor,
                    textColor: AppColors.blackColor,
                    textFontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: getWidth() * 0.04),
                Expanded(
                  child: CustomButton(
                    buttonText: al.viewDetails,
                    onTap: () {
                      context.push(Routes.customerNonEventInviteRoute);
                    },
                    height: getHeight() * 0.055,
                    backgroundColor:
                    AppColors.getPrimaryColorFromContext(context),
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class UserInterestView extends StatelessWidget {
  const UserInterestView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(4, (i) => {
      "title": "Event Name ${i + 1}",
      "datetime": "Aug ${28 + i}, 10:00 AM - 11:00 AM",
      "location": "12 Rue de Rivoli, 75001 Paris, France",
      "image": Assets.restaurantImage,
      "participants": [
        Assets.restaurantImage,
        Assets.wellnessImage,
        Assets.leisureImage,
        Assets.peopleIcon,
      ],
    });

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: getHeight() * 0.02,
      ),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: getHeight() * 0.018),
      itemBuilder: (context, index) {
        final item = items[index];
        return _InterestCard2(
          title: item["title"] as String,
          dateTime: item["datetime"] as String,
          location: item["location"] as String,
          imageAsset: item["image"] as String,
          participants: List<String>.from(item["participants"] as List),
        );
      },
    );
  }
}

class _InterestCard2 extends StatelessWidget {
  final String title;
  final String dateTime;
  final String location;
  final String imageAsset;
  final List<String> participants;

  const _InterestCard2({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.imageAsset,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: EdgeInsets.all(getWidth() * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image + Event Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageAsset,
                    width: getWidth() * 0.25,
                    height: getWidth() * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: getWidth() * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        fontSize: sizes?.fontSize16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                        textOverflow: TextOverflow.ellipsis,
                        lines: 1,
                      ),
                      SizedBox(height: getHeight() * 0.010),

                      // Date
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.calender,
                            height: getHeight() * 0.018,
                            width: getHeight() * 0.018,
                            colorFilter: ColorFilter.mode(
                              AppColors.getPrimaryColorFromContext(context),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.02),
                          Expanded(
                            child: CustomText(
                              text: dateTime,
                              fontSize: sizes?.fontSize14,
                              color: AppColors.inputHintColor,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis,
                              lines: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: getHeight() * 0.008),

                      // Location
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: getHeight() * 0.005),
                            child: SvgPicture.asset(
                              Assets.locationIcon,
                              height: getHeight() * 0.019,
                              width: getHeight() * 0.019,
                              colorFilter: ColorFilter.mode(
                                AppColors.getPrimaryColorFromContext(context),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.02),
                          Expanded(
                            child: CustomText(
                              text: location,
                              fontSize: sizes?.fontSize14,
                              color: AppColors.inputHintColor,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis,
                              lines: 2,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: getHeight() * 0.015),

                      // Participants
                      SizedBox(
                        height: getHeight() * 0.04,
                        child: Stack(
                          children: List.generate(
                            participants.length,
                                (i) => Positioned(
                              left: i * getWidth() * 0.06,
                              child: CircleAvatar(
                                radius: getHeight() * 0.02,
                                backgroundImage: AssetImage(participants[i]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: getHeight() * 0.025),

            // Single Full-Width Button
            CustomButton(
              buttonText: al.viewDetails,
              onTap: () {
                context.push(Routes.interestedDetailsRoute);
              },
              height: getHeight() * 0.055,
              backgroundColor: AppColors.getPrimaryColorFromContext(context),
              borderColor: AppColors.getPrimaryColorFromContext(context),
              textColor: Colors.white,
              textFontWeight: FontWeight.w600,
              buttonWidth: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

