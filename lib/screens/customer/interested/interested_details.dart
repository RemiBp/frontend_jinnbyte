import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/customer/interested/suggest_timeslot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../../res/res.dart';
import '../../../l18n.dart';

class InterestDetailsScreen extends StatefulWidget {
  const InterestDetailsScreen({super.key});

  @override
  State<InterestDetailsScreen> createState() => _InterestDetailsScreenState();
}

class _InterestDetailsScreenState extends State<InterestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      // AppBar
      appBar: CommonAppBar(title: al.interestDetails),

      // Bottom Buttons
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.all(sizes!.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: AppColors.greyBordersColor,
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: getHeight() * 0.012),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: al.editTime,
                    onTap: () {
                      context.push(
                        Routes.suggestTimeSlotRoute,
                        extra: TimeSlotMode.edit, // pass the enum here
                      );
                    },
                    buttonWidth: double.infinity,
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.blackColor,
                    textColor: AppColors.blackColor,
                  ),
                ),
                SizedBox(width: getWidth() * 0.03),
                Expanded(
                  child: CustomButton(
                    buttonText: al.reserveNow,
                    onTap: () {

                    },
                    buttonWidth: double.infinity,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context),
                    borderColor: AppColors.getPrimaryColorFromContext(context),
                    textColor: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Body
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding,
          vertical: getHeight() * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // EVENT INFO
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Image increased size for better balance
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    Assets.restaurantImage,
                    height: getHeight() * 0.11,
                    width: getHeight() * 0.11,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: getWidth() * 0.03),

                // Event Text Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: al.eventName,
                        fontSize: sizes?.fontSize16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(height: getHeight() * 0.008),

                      //Date Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.calendarIcon,
                            height: getHeight() * 0.022,
                            colorFilter: ColorFilter.mode(
                              AppColors.getPrimaryColorFromContext(context),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.02),
                          Expanded(
                            child: CustomText(
                              text: "Aug 28, 10:00 AM - 11:00 AM",
                              fontSize: sizes?.fontSize12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: getHeight() * 0.008),

                      // Location Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            Assets.locationIcon,
                            height: getHeight() * 0.02,
                            colorFilter: ColorFilter.mode(
                              AppColors.getPrimaryColorFromContext(context),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: getWidth() * 0.02),
                          Expanded(
                            child: CustomText(
                              text:
                              "12 Rue de, 75001 Paris, France",
                              fontSize: sizes?.fontSize12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: getHeight() * 0.04),

            // INVITEES SECTION
            CustomText(
              text: al.invitees,
              fontSize: sizes?.fontSize15,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * 0.02),

            // Invitee List with Divider
            _InviteeTile(
              name: "Emelie",
              statusText: al.joined,
              statusColor: Colors.green,
              imageAsset: Assets.peopleIcon,
            ),
            Divider(color: AppColors.greyBordersColor, height: getHeight() * 0.03),

            _InviteeTile(
              name: "Abigail",
              statusText: al.declined,
              statusColor: Colors.red,
              imageAsset: Assets.profileIcon,
              showSuggestion: true,
            ),
            Divider(color: AppColors.greyBordersColor, height: getHeight() * 0.03),

            _InviteeTile(
              name: "Penelope",
              statusText: al.joined,
              statusColor: Colors.green,
              imageAsset: Assets.peopleIcon,
            ),
          ],
        ),
      ),
    );
  }
}

// Invitee Tile
class _InviteeTile extends StatelessWidget {
  final String name;
  final String statusText;
  final Color statusColor;
  final String imageAsset;
  final bool showSuggestion;

  const _InviteeTile({
    required this.name,
    required this.statusText,
    required this.statusColor,
    required this.imageAsset,
    this.showSuggestion = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name + Status Row
        Row(
          children: [
            CircleAvatar(
              radius: getHeight() * 0.022,
              backgroundImage: AssetImage(imageAsset),
            ),
            SizedBox(width: getWidth() * 0.03),
            Expanded(
              child: CustomText(
                text: name,
                fontSize: sizes?.fontSize14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth() * 0.03,
                vertical: getHeight() * 0.004,
              ),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomText(
                text: statusText,
                fontSize: sizes?.fontSize12,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        // Suggested Time Box (if any)
        if (showSuggestion) ...[
          SizedBox(height: getHeight() * 0.012),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.greyBordersColor, // thin gray border
                width: 1,
              ),
            ),
            padding: EdgeInsets.all(getWidth() * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Suggested Date & Time Section
                CustomText(
                  text: al.suggestedDateTime,
                  fontSize: sizes?.fontSize10,
                  fontFamily: Assets.onsetMedium,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                SizedBox(height: getHeight() * 0.006),
                CustomText(
                  text: "Aug 29, 10:00 AM - 11:00 AM",
                  fontFamily: Assets.onsetRegular,
                  fontSize: sizes?.fontSize10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor,
                ),

                // Divider line
                Padding(
                  padding: EdgeInsets.symmetric(vertical: getHeight() * 0.012),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.greyBordersColor,
                  ),
                ),

                // Reason Section
                CustomText(
                  text: al.reason,
                  fontFamily: Assets.onsetMedium,
                  fontSize: sizes?.fontSize10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                SizedBox(height: getHeight() * 0.005),
                CustomText(
                  text:
                  "Lorem ipsum dolor sit amet consectetur. Et gravida odio leo ut.",
                  fontSize: sizes?.fontSize10,
                  fontFamily: Assets.onsetRegular,
                  fontWeight: FontWeight.w400,
                  color: AppColors.inputHintColor,
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }
}
