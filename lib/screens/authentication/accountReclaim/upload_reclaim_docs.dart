import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/authentication/accountReclaim/reclaim_account_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../../../utilities/extensions.dart';
import '../auth_provider.dart';

class UploadReclaimDocs extends StatefulWidget {
  const UploadReclaimDocs({super.key});

  @override
  State<UploadReclaimDocs> createState() => _UploadReclaimDocsState();
}

class _UploadReclaimDocsState extends State<UploadReclaimDocs> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReclaimAccountProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(backgroundColor: AppColors.whiteColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth() * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Upload Documents",
              fontSize: sizes?.fontSize26,
              fontFamily: Assets.onsetSemiBold,
            ),

            CustomText(
              text: "Please upload your document to proceed with verification.",
              fontSize: sizes?.fontSize16,
              color: AppColors.primarySlateColor,
              giveLinesAsText: true,
            ),
            SizedBox(height: getHeight() * .02),
            SizedBox(
              height: getHeight() * .03,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: provider.docs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: getWidth() * .02),
                        width: getWidth() * .1,
                        child: Divider(
                          color: AppColors.getPrimaryColorFromContext(context),
                          thickness:
                          provider.step > index ? getHeight() * .0038 : null,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: provider.docs[provider.step],
              fontSize: sizes?.fontSize18,
              fontFamily: Assets.onsetSemiBold,
            ),

            SizedBox(height: getHeight() * .01),
            CustomText(
              text: "Upload Documents",
              fontSize: sizes?.fontSize14,
              fontFamily: Assets.onsetMedium,
            ),
            SizedBox(height: getHeight() * .02),
            InkWell(
              onTap: () {
                authProvider.pickFile(1);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: DottedBorder(
                  options: RectDottedBorderOptions(
                    padding: EdgeInsets.all(22),
                    dashPattern: [10, 10],
                    color: AppColors.inputHintColor,
                  ),
                  child: SizedBox(
                    width: getWidth(),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: HexColor.fromHex("#FEF5E7"),
                          child: SvgPicture.asset(Assets.pdfIcon),
                        ),
                        SizedBox(height: getHeight() * .01),
                        if (authProvider.selectedDoc1 != null) ...[
                          CustomText(
                            text: authProvider.selectedDoc1?.name ?? "",
                            fontSize: sizes!.fontSize12,
                            color: AppColors.primarySlateColor,
                          ),
                        ] else ...[
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
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Spacer(),
            provider.step == 0
                ? CustomButton(
                  buttonText: "Continue",
                  onTap: () {
                    provider.updatedStep = 1;
                  },
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      backgroundColor: Colors.transparent,
                      buttonText: "Back",
                      textColor: AppColors.blackColor,
                      borderColor: AppColors.blackColor,
                      onTap: () {
                        provider.updatedStep = provider.step - 1;
                      },
                      buttonWidth: getWidth() * .43,
                    ),
                    CustomButton(
                      buttonText: "Continue",
                      onTap: () {
                        if (provider.step == provider.docs.length-1) {
                          context.push(Routes.reviewRoute);
                          return;
                        }
                        provider.updatedStep = provider.step + 1;
                      },
                      buttonWidth: getWidth() * .43,
                    ),
                  ],
                ),

            SizedBox(height: getHeight() * .05),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final String svgString;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.selectedColor,
    required this.svgString,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? selectedColor : AppColors.greyBordersColor,
                width: 2.0,
              ),
            ),
            padding: EdgeInsets.all(getHeight() * .02),
            child: SvgPicture.asset(svgString, height: getHeight() * .035),
          ),
          const SizedBox(height: 8),
          CustomText(
            text: label,
            fontSize: sizes?.fontSize12,
            fontFamily: Assets.onsetMedium,
            color: AppColors.primarySlateColor,
          ),
        ],
      ),
    );
  }
}
