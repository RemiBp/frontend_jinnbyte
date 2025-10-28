import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../l18n.dart';
import 'interestedWidgets/time_slot_widgets.dart';

class CustomerEventInvite extends StatefulWidget {
  const CustomerEventInvite({super.key});

  @override
  State<CustomerEventInvite> createState() => _CustomerEventInviteState();
}

class _CustomerEventInviteState extends State<CustomerEventInvite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Lorem Ipsum"),

      // Bottom Navigation Buttons
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(
          sizes!.pagePadding,
          getHeight() * 0.01,
          sizes!.pagePadding,
          getHeight() * 0.02,
        ),
        child: Row(
          children: [
            // Decline Button
            Expanded(
              child: CustomButton(
                buttonText: al.decline,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => DeclineReasonDialog(
                      onSubmit: (reason) {
                        debugPrint("Decline reason: $reason");
                        // You can handle your API call or state update here.
                      },
                    ),
                  );                },
                height: getHeight() * 0.06,
                backgroundColor: Colors.transparent,
                borderColor: AppColors.blackColor,
                textColor: AppColors.blackColor,
                textFontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: getWidth() * 0.04),

            // Confirm Button
            Expanded(
              child: CustomButton(
                buttonText: al.confirm,
                onTap: () {
                  // handle confirm action
                },
                height: getHeight() * 0.06,
                backgroundColor: AppColors.getPrimaryColorFromContext(context),
                borderColor:AppColors.getPrimaryColorFromContext(context) ,
                textColor: AppColors.whiteColor,
                textFontWeight: FontWeight.w600,
              ),
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
            // Event title
            CustomText(
              text: "Flavors of the Season",
              fontSize: sizes?.fontSize18,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * 0.015),

            // Calendar Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BlueIconContainer(context: context, svgPath: Assets.calendarIcon),
                SizedBox(width: getWidth() * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "${al.monday}, ${al.june} 28, 2025",
                        fontFamily: Assets.onsetMedium,
                        fontSize: sizes?.fontSize15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                      CustomText(
                        text: "08:00 PM - 11:00 PM",
                        fontFamily: Assets.onsetRegular,
                        fontSize: sizes?.fontSize12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.inputHintColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight() * 0.02),

            // Location Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _BlueIconContainer(context: context, svgPath: Assets.locationIcon),
                SizedBox(width: getWidth() * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Rivoli, Paris, France",
                        fontFamily: Assets.onsetMedium,
                        fontSize: sizes?.fontSize15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(height: getHeight() * 0.004),
                      CustomText(
                        text: "12 Rue de Rivoli, 75001 Paris, France",
                        fontFamily: Assets.onsetRegular,
                        fontSize: sizes?.fontSize12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.inputHintColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Blue Circular Icon with Bigger Size
  Widget _BlueIconContainer({
    required BuildContext context,
    required String svgPath,
  }) {
    return Container(
      width: getHeight() * 0.045, // Increased from 0.04
      height: getHeight() * 0.045, // Increased from 0.04
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColorFromContext(context).withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          height: getHeight() * 0.025, // Increased from 0.02
          colorFilter: ColorFilter.mode(
            AppColors.getPrimaryColorFromContext(context),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
