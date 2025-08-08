import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/res/res.dart';
import 'package:flutter/material.dart';

import '../../../appAssets/app_assets.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  static const Color kTitle = Color(0xFF0E1231);
  static const Color kSubtitle = Color(0xFF5E627D);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final pad = w * 0.08;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(pad, 32, pad, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Big whitespace like the mock
                SizedBox(height: getHeight() * .02),
                Center(child: Image.asset(Assets.waiting)),

                SizedBox(height: getHeight() * .02),

                CustomText(
                  text: "Thank you!",
                  fontSize: sizes?.fontSize24,
                  fontFamily: Assets.onsetSemiBold,
                ),
                CustomText(
                  text:
                      "Your profile are now under review. We will get back to you in two business day.",
                  fontSize: sizes?.fontSize16,
                  fontFamily: Assets.onsetMedium,
                  color: AppColors.primarySlateColor,
                  giveLinesAsText: true,
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
