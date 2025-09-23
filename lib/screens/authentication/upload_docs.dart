import 'package:choice_app/utilities/extensions.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';

class UploadDocs extends StatelessWidget {
  const UploadDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * .05,
          vertical: getHeight() * .1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (context.canPop()) ...[
                  CustomBackButton(),
                  SizedBox(width: getWidth() * .02),
                ],
                CustomText(
                  text: al.uploadDocumentsTitle,
                  fontSize: sizes?.fontSize28,
                  fontFamily: Assets.onsetSemiBold,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.uploadDocumentsSubtitle,
              fontSize: sizes?.fontSize16,
              color: AppColors.primarySlateColor,
              giveLinesAsText: true,
            ),
            SizedBox(height: getHeight() * .03),

            CustomText(
              text: al.businessRegistrationDocument,
              fontSize: sizes?.fontSize18,
              fontFamily: Assets.onsetSemiBold,
              giveLinesAsText: true,
            ),
            SizedBox(height: getHeight() * .015),
            Row(
              children: [
                CustomText(
                  text: al.expiryDate,
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                ),
                CustomText(
                  text: ' *',
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                  color: AppColors.redColor,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.greyBordersColor),
              ),
              padding: EdgeInsets.all(getHeight() * .017),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: al.selectDate,
                    fontSize: sizes!.fontSize16,
                    color: AppColors.inputHintColor,
                  ),
                  Icon(Icons.calendar_month, color: AppColors.inputHintColor),
                ],
              ),
            ),
            SizedBox(height: getHeight() * .02),
            Row(
              children: [
                CustomText(
                  text: al.uploadDocumentsTitle,
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                ),
                CustomText(
                  text: ' *',
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                  color: AppColors.redColor,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: DottedBorder(
                options: RectDottedBorderOptions(
                  padding: EdgeInsets.all(22),
                  dashPattern: [10, 10],
                  color: AppColors.inputHintColor,
                ),
                child:  SizedBox(
                  width: getWidth(),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: HexColor.fromHex("#FEF5E7"),
                        child: SvgPicture.asset(Assets.pdfIcon),
                      ),
                      SizedBox(height: getHeight() * .01),
                      CustomText(
                        text: al.chooseFile,
                        fontSize: sizes!.fontSize14,
                        fontFamily: Assets.onsetMedium,
                      ),
                      // SizedBox(height: getHeight() * .01),
                      CustomText(
                        text: al.maxFileSizeNote,
                        fontSize: sizes!.fontSize12,
                        color: AppColors.primarySlateColor,
                      ),
                    ],
                  ),
                )
              ),
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.utilityBillOrInvoice,
              fontSize: sizes?.fontSize18,
              fontFamily: Assets.onsetSemiBold,
            ),
            SizedBox(height: getHeight() * .02),
            Row(
              children: [
                CustomText(
                  text: al.expiryDate,
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                ),
                CustomText(
                  text: ' *',
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                  color: AppColors.redColor,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.greyBordersColor),
              ),
              padding: EdgeInsets.all(getHeight() * .017),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: al.selectDate,
                    fontSize: sizes!.fontSize16,
                    color: AppColors.inputHintColor,
                  ),
                  Icon(Icons.calendar_month, color: AppColors.inputHintColor),
                ],
              ),
            ),
            SizedBox(height: getHeight() * .02),
            Row(
              children: [
                CustomText(
                  text: al.uploadDocumentsTitle,
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                ),
                CustomText(
                  text: ' *',
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                  color: AppColors.redColor,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: DottedBorder(
                  options: RectDottedBorderOptions(
                    padding: EdgeInsets.all(22),
                    dashPattern: [10, 10],
                    color: AppColors.inputHintColor,
                  ),
                  child:  SizedBox(
                    width: getWidth(),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: HexColor.fromHex("#FEF5E7"),
                          child: SvgPicture.asset(Assets.pdfIcon),
                        ),
                        SizedBox(height: getHeight() * .01),
                        CustomText(
                          text: al.chooseFile,
                          fontSize: sizes!.fontSize14,
                          fontFamily: Assets.onsetMedium,
                        ),
                        // SizedBox(height: getHeight() * .01),
                        CustomText(
                          text: al.maxFileSizeNote,
                          fontSize: sizes!.fontSize12,
                          color: AppColors.primarySlateColor,
                        ),
                      ],
                    ),
                  )
              ),
            ),
            SizedBox(height: getHeight() * .05),
            CustomButton(
              buttonText: al.submitForReview,
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
