import 'package:choice_app/customWidgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen>
    with SingleTickerProviderStateMixin {
  bool isProSelected = false;
  bool showBottomDialog = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSubscribeTap() {
    if (isProSelected) {
      setState(() => showBottomDialog = true);
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = AppColors.getPrimaryColorFromContext(context);

    return Stack(
      children: [
        // Base scaffold
        Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CommonAppBar(title: 'Subscription'),

          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sizes!.pagePadding,
              vertical: getHeight() * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Unlock more with Plus",
                  fontSize: getWidth() * 0.05,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
                SizedBox(height: getHeight() * 0.005),
                CustomText(
                  text: "Get our more capable models and features",
                  fontSize: getWidth() * 0.035,
                  fontWeight: FontWeight.w400,
                  color: AppColors.inputHintColor,
                ),
                SizedBox(height: getHeight() * 0.03),
                _buildFreeCard(),
                SizedBox(height: getHeight() * 0.015),
                _buildProCard(themeColor),
              ],
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(sizes!.pagePadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    buttonText: "Subscribe",
                    onTap: onSubscribeTap,
                    buttonWidth: double.infinity,
                    backgroundColor: themeColor,
                    borderColor: Colors.transparent,
                    textColor: AppColors.whiteColor,
                    textFontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: getHeight() * 0.015),
                  CustomText(
                    text:
                    "Lorem ipsum dolor sit amet consectetur. Et hendrerit lectus mus ut amet cursus vulputate et amet. Et interdum elementum massa elementum odio elit habitasse.",
                    fontSize: getWidth() * 0.03,
                    fontWeight: FontWeight.w400,
                    color: AppColors.inputHintColor,
                    textAlign: TextAlign.center,
                    lines: 3,
                  ),
                  SizedBox(height: getHeight() * 0.02),
                ],
              ),
            ),
          ),
        ),

        // Overlay dialog
        if (showBottomDialog)
          Positioned.fill(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                //Background dimmer
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showBottomDialog = false;
                      _controller.reverse();
                    });
                  },
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ),

                // Dialog bottom sheet
                SlideTransition(
                  position: _offsetAnimation,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: getWidth() > 390 ? 390 : getWidth(),
                      height: 306, // exact px
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth() * 0.05,
                        vertical: getHeight() * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Google Play",
                            fontSize: 14,
                            fontFamily: Assets.onsetMedium,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: getHeight() * 0.008),
                          Divider(
                            color: AppColors.greyBordersColor,
                            thickness: 1,
                            height: 1,
                          ),
                          SizedBox(height: getHeight() * 0.02),
                          CustomText(
                            text: "Start by adding a payment method",
                            fontSize: 16,
                            fontFamily: Assets.onsetSemiBold,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: getHeight() * 0.004),
                          CustomText(
                            text: "example@gmail.com",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: Assets.onsetRegular,
                          ),
                          SizedBox(height: getHeight() * 0.02),
                          CustomText(
                            text:
                            "Add a payment method to your Google Account to complete your purchase. Your payment information is only visible to Google.",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: Assets.onsetRegular,
                            lines: 4,
                          ),
                          SizedBox(height: getHeight() * 0.05),
                          SecondaryCustomIconButton(
                            buttonText: "Add credit or debit card",
                            onTap: () {
                              setState(() {
                                showBottomDialog = false;
                                _controller.reverse();
                              });
                            },
                            prefixIcon: SvgPicture.asset(
                              Assets.paymentIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(AppColors.whiteColor,BlendMode.srcIn)
                            ),
                            buttonWidth: double.infinity,
                            height: getHeight() * 0.055,
                            backgroundColor: AppColors.getPrimaryColorFromContext(context),
                            textColor: AppColors.whiteColor,
                            textFontWeight: FontWeight.w600,
                            textFontFamily: Assets.onsetSemiBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFreeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(getWidth() * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(getWidth() * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth() * 0.025, vertical: getHeight() * 0.004),
            decoration: BoxDecoration(
              color: AppColors.greyBordersColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(getWidth() * 0.02),
            ),
            child: CustomText(
              text: "Current Plan",
              fontSize: getWidth() * 0.028,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(height: getHeight() * 0.008),
          CustomText(
            text: "Free",
            fontSize: getWidth() * 0.04,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
          CustomText(
            text: "\$0.00/month",
            fontSize: getWidth() * 0.035,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
          SizedBox(height: getHeight() * 0.008),
          Row(
            children: [
              Icon(Icons.check, color: Colors.green, size: getWidth() * 0.04),
              SizedBox(width: getWidth() * 0.02),
              CustomText(
                text: "Limited AI Copilot Queries",
                fontSize: getWidth() * 0.03,
                fontWeight: FontWeight.w400,
                color: AppColors.inputHintColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProCard(Color themeColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isProSelected = !isProSelected;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(getWidth() * 0.04),
            decoration: BoxDecoration(
              color: isProSelected
                  ? themeColor.withValues(alpha: 0.1)
                  : AppColors.whiteColor,
              border: Border.all(
                color: isProSelected
                    ? themeColor
                    : AppColors.greyBordersColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(getWidth() * 0.03),
              boxShadow: [
                if (!isProSelected)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Pro",
                  fontSize: getWidth() * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
                CustomText(
                  text: "\$2.00/month",
                  fontSize: getWidth() * 0.035,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor,
                ),
                SizedBox(height: getHeight() * 0.008),
                Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: getWidth() * 0.04),
                    SizedBox(width: getWidth() * 0.02),
                    CustomText(
                      text: "Unlimited AI Copilot Queries",
                      fontSize: getWidth() * 0.03,
                      fontWeight: FontWeight.w400,
                      color: AppColors.inputHintColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tick mark top right outside
          if (isProSelected)
            Positioned(
              top: -getHeight() * 0.008,
              right: -getWidth() * 0.02,
              child: Container(
                height: getWidth() * 0.07,
                width: getWidth() * 0.07,
                decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: themeColor.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.whiteColor,
                  size: getWidth() * 0.035,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
