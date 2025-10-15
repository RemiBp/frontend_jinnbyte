import 'package:flutter/material.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/common_app_bar.dart';
import 'package:choice_app/res/res.dart';

import '../../../l18n.dart';

class SuggestEventScreen extends StatefulWidget {
  const SuggestEventScreen({super.key});

  @override
  State<SuggestEventScreen> createState() =>
      _SuggestEventScreenState();
}

class _SuggestEventScreenState
    extends State<SuggestEventScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Suggest a Time Slot"),

      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.all(sizes!.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 👈 so it wraps content tightly
          children: [
            Divider(
              color: AppColors.greyBordersColor,
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: getHeight() * 0.012), // small space after divider
            CustomButton(
              buttonText: al.continueText,
              onTap: () {


              },
              buttonWidth: double.infinity,
              backgroundColor: AppColors.getPrimaryColorFromContext(context),
              borderColor: Colors.transparent,
              textColor: AppColors.whiteColor,
              textFontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding,
          vertical: getHeight() * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(getWidth() * 0.04),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Event Name:",
                    fontSize: sizes!.fontSize12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor.withOpacity(0.6),
                  ),
                  SizedBox(height: getHeight() * 0.004),
                  CustomText(
                    text: "Flavors of the Season",
                    fontSize: sizes!.fontSize14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(height: getHeight() * 0.018),

                  CustomText(
                    text: "Date:",
                    fontSize: sizes!.fontSize12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor.withOpacity(0.6),
                  ),
                  SizedBox(height: getHeight() * 0.004),
                  CustomText(
                    text: "June 28, 2025",
                    fontSize: sizes!.fontSize14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(height: getHeight() * 0.018),

                  CustomText(
                    text: "Time:",
                    fontSize: sizes!.fontSize12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor.withOpacity(0.6),
                  ),
                  SizedBox(height: getHeight() * 0.004),
                  CustomText(
                    text: "08:00 PM - 11:00 PM",
                    fontSize: sizes!.fontSize14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(height: getHeight() * 0.018),

                  CustomText(
                    text: "Location:",
                    fontSize: sizes!.fontSize12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor.withOpacity(0.6),
                  ),
                  SizedBox(height: getHeight() * 0.004),
                  CustomText(
                    text: "12 Rue de Rivoli, 75001 Paris, France",
                    fontSize: sizes!.fontSize14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                    giveLinesAsText: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: getHeight() * 0.025),

            // Message Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(getWidth() * 0.04),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: "Message",
                        fontSize: sizes!.fontSize14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                      CustomText(
                        text: " *",
                        fontSize: sizes!.fontSize14,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight() * 0.012),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.greyBordersColor),
                    ),
                    child: TextField(
                      controller: _messageController,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: sizes!.fontSize14,
                        color: AppColors.blackColor,
                      ),
                      decoration: InputDecoration(
                        hintText: "e.g. Let’s try this Friday night...?",
                        hintStyle: TextStyle(
                          color: AppColors.inputHintColor,
                          fontSize: sizes!.fontSize14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(getWidth() * 0.04),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight() * 0.08),
          ],
        ),
      ),
    );
  }
}
