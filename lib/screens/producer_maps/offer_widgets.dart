import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';
import '../../customWidgets/custom_textfield.dart';
import '../../l18n.dart';
import '../customer/interested/interestedWidgets/time_slot_widgets.dart';
import 'offer_provider.dart';

import 'package:provider/provider.dart';


class OfferTemplateBottomSheet extends StatefulWidget {
  const OfferTemplateBottomSheet({super.key});

  @override
  State<OfferTemplateBottomSheet> createState() =>
      _OfferTemplateBottomSheetState();
}

class _OfferTemplateBottomSheetState extends State<OfferTemplateBottomSheet> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final templates = context.watch<TemplateProvider>().templates;
    final hasOffers = templates.isNotEmpty;

    return SafeArea(
      top: false,
      child: Container(
        // Dynamically adjust height
        height: hasOffers ? getHeight() * 0.55 : null,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.06, vertical: getHeight() * 0.02),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gray bar
            Container(
              margin: EdgeInsets.only(bottom: getHeight() * 0.015),
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(14),
              ),
            ),

            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: al.offerTemplate,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: Assets.onsetSemiBold,
                ),
                Row(
                  children: [
                    if (hasOffers)
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const TargetedNotificationBottomSheet(),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add,
                                size: 18,
                                color: AppColors.getPrimaryColorFromContext(context)),
                            SizedBox(width: getWidth() * 0.01),
                            CustomText(
                              text: al.createOffer,
                              fontSize: 13,
                              color: AppColors.getPrimaryColorFromContext(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    if (hasOffers) SizedBox(width: getWidth() * 0.04),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: getHeight() * 0.02),

            // Body
            if (hasOffers)
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: _buildTemplateList(context, templates)),
                    SizedBox(height: getHeight() * 0.015),
                    CustomButton(
                      buttonText: al.continueText,
                      onTap: selectedIndex != null
                          ? () {
                        Navigator.pop(context);
                        // Handle next step
                      }
                          : null,
                      backgroundColor: selectedIndex != null
                          ? AppColors.getPrimaryColorFromContext(context)
                          : Colors.grey.shade400,
                      borderColor: selectedIndex != null
                          ? AppColors.getPrimaryColorFromContext(context)
                          : Colors.grey.shade400,
                    ),
                    SizedBox(height: getHeight() * 0.02),
                  ],
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(bottom: getHeight() * 0.01),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: getWidth() * 0.21,
                      width: getWidth() * 0.21,
                      decoration: BoxDecoration(
                        color: AppColors.getPrimaryColorFromContext(context)
                            .withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.folderIcon,
                          colorFilter: ColorFilter.mode(
                            AppColors.getPrimaryColorFromContext(context),
                            BlendMode.srcIn,
                          ),
                          height: getWidth() * 0.125,
                          width: getWidth() * 0.125,
                        ),
                      ),
                    ),
                    SizedBox(height: getHeight() * 0.02),
                    CustomText(
                      text: al.noTemplateYet,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: Assets.onsetSemiBold,
                    ),
                    SizedBox(height: getHeight() * 0.005),
                    CustomText(
                      text:
                      al.templateInfo,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      fontFamily: Assets.onsetMedium,
                      giveLinesAsText: true,
                    ),
                    SizedBox(height: getHeight() * 0.03),
                    CustomButton(
                      buttonText: al.createOffer,
                      backgroundColor: AppColors.getPrimaryColorFromContext(context),
                      borderColor: AppColors.getPrimaryColorFromContext(context),
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const TargetedNotificationBottomSheet(),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Empty State (no offers yet)

  Widget _buildEmptyBody(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: getWidth() * 0.21,
            width: getWidth() * 0.21,
            decoration: BoxDecoration(
              color: AppColors.getPrimaryColorFromContext(context)
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.folderIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.getPrimaryColorFromContext(context),
                  BlendMode.srcIn,
                ),
                height: getWidth() * 0.125,
                width: getWidth() * 0.125,
              ),
            ),
          ),
          SizedBox(height: getHeight() * 0.02),
          CustomText(
            text: al.noTemplateYet,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            fontFamily: Assets.onsetSemiBold,
          ),
          SizedBox(height: getHeight() * 0.005),
          CustomText(
            text:
            al.templateInfo,
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            fontFamily: Assets.onsetMedium,
            giveLinesAsText: true,
          ),
          const Spacer(),
          CustomButton(
            buttonText: al.createOffer,
            backgroundColor: AppColors.getPrimaryColorFromContext(context),
            borderColor: AppColors.getPrimaryColorFromContext(context),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const TargetedNotificationBottomSheet(),
              );
            },
          ),
        ],
      ),
    );
  }

  //  Saved Offers List
  Widget _buildTemplateList(BuildContext context, List<Template> templates) {
    return ListView.builder(
      itemCount: templates.length,
      padding: EdgeInsets.only(bottom: getHeight() * 0.02),
      itemBuilder: (context, index) {
        final t = templates[index];
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIndex == index) {
                selectedIndex = null; // unselect
              } else {
                selectedIndex = index;
              }
            });
          },
          child: Container(
            margin: EdgeInsets.only(bottom: getHeight() * 0.015),
            padding: EdgeInsets.all(getWidth() * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon
                SvgPicture.asset(
                  Assets.folderIcon,
                  colorFilter: ColorFilter.mode(
                    AppColors.getPrimaryColorFromContext(context),
                    BlendMode.srcIn,
                  ),
                  height: getWidth() * 0.07,
                  width: getWidth() * 0.07,
                ),
                SizedBox(width: getWidth() * 0.03),

                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: t.title,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: Assets.onsetMedium,
                      ),
                      SizedBox(height: getHeight() * 0.006),
                      CustomText(
                        text: "${t.reduction}% OFF - ${t.message}",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: Assets.onsetRegular,
                      ),
                    ],
                  ),
                ),

                // Radio button
                Radio<int?>(
                  value: index,
                  groupValue: selectedIndex,
                  activeColor: AppColors.getPrimaryColorFromContext(context),
                  onChanged: (val) {
                    setState(() {
                      if (selectedIndex == val) {
                        selectedIndex = null;
                      } else {
                        selectedIndex = val;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class TargetedNotificationBottomSheet extends StatelessWidget {
  const TargetedNotificationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final msg = TextEditingController();
    final reduction = TextEditingController();
    final validate = TextEditingController();
    final users = TextEditingController();
    final distance = TextEditingController();

    Widget label(String text) => RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: AppColors.blackColor,
          fontSize: getWidth() * 0.034,
          fontFamily: Assets.onsetSemiBold,
        ),
        children: const [
          TextSpan(text: " *", style: TextStyle(color: Colors.red)),
        ],
      ),
    );

    Widget field(String labelText, TextEditingController ctrl, String hint,
        {bool isMsg = false}) {
      return Padding(
        padding: EdgeInsets.only(bottom: getHeight() * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label(labelText),
            SizedBox(height: 6),
            isMsg
                ? MessageField(
              controller: ctrl,
              hintText: hint,
              backgroundColor: AppColors.whiteColor,
              borderColor: AppColors.inputHintColor
            )
                : CustomField2(
              textEditingController: ctrl,
              borderColor: AppColors.greyBordersColor,
              hint: hint,
              label: null,
              bgColor: AppColors.whiteColor,
            ),
          ],
        ),
      );
    }

    return DraggableScrollableSheet(
      initialChildSize: 1.0, //  full height
      maxChildSize: 1.0,
      expand: false,
      builder: (context, scroll) => Material(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
          child: ListView(
            controller: scroll,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: getHeight() * 0.02),

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: al.targetedNotification,
                    fontWeight: FontWeight.w600,
                    fontFamily: Assets.onsetSemiBold,
                    fontSize: 16,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
              CustomText(
                text: al.step1WriteOffer,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: getHeight() * 0.025),

              // Fields
              field(al.title, title, "e.g: Flash Offer"),
              field(al.message, msg, al.exampleOffer, isMsg: true),
              field(al.reductionPercent, reduction, "e.g: 15"),
              field(al.validateMinutes, validate, "e.g: 45"),
              field(al.numberOfUsers, users, "e.g: 20"),
              field(al.distance, distance, "e.g: 300m"),

              SizedBox(height: getHeight() * 0.03),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonText: al.cancel,
                      onTap: () => Navigator.pop(context),
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.blackColor,
                      textColor: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(width: getWidth() * 0.04),
                  Expanded(
                    child: CustomButton(
                        buttonText: al.next,
                        onTap: () {
                          Navigator.pop(context); // close step 1
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => TargetedNotificationPreviewSheet(
                              data: TargetedNotificationData(
                                title: title.text,
                                message: msg.text,
                                reduction: reduction.text,
                              ),
                            ),
                          );
                        },
                        backgroundColor: AppColors.getPrimaryColorFromContext(context),
                        borderColor: AppColors.getPrimaryColorFromContext(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getHeight() * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}

class TargetedNotificationData {
  final String title;
  final String message;
  final String reduction;

  TargetedNotificationData({
    required this.title,
    required this.message,
    required this.reduction,
  });
}


class TargetedNotificationPreviewSheet extends StatefulWidget {
  final TargetedNotificationData data;
  const TargetedNotificationPreviewSheet({super.key, required this.data});

  @override
  State<TargetedNotificationPreviewSheet> createState() =>
      _TargetedNotificationPreviewSheetState();
}

class _TargetedNotificationPreviewSheetState
    extends State<TargetedNotificationPreviewSheet> {
  bool saveTemplate = false;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: 342,
        height: 477,
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * 0.05,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: al.targetedNotification,
                  fontWeight: FontWeight.w600,
                  fontFamily: Assets.onsetSemiBold,
                  fontSize: 16,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
            SizedBox(height: getHeight() * 0.006),
            CustomText(
              text: al.step2ChooseTarget,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: Assets.onsetRegular,
            ),
            SizedBox(height: getHeight() * 0.025),

            // Card 1
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(getWidth() * 0.04),
              decoration: BoxDecoration(
                color: AppColors.getPrimaryColorFromContext(context)
                    .withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.groupIcon,
                    width: getWidth() * 0.064,
                    height: getHeight() * 0.0295,
                    colorFilter: ColorFilter.mode(AppColors.getPrimaryColorFromContext(context),BlendMode.srcIn),
                  ),
                  SizedBox(width: getWidth() * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: al.allNearbyUsers,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: Assets.onsetMedium,
                        ),
                        CustomText(
                          text: al.allActiveUsers,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: Assets.onsetRegular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: getHeight() * 0.025),

            // Estimated Users
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Assets.groupIcon, //  use the right icon
                      width: getWidth() * 0.045,
                      colorFilter: ColorFilter.mode(AppColors.inputHintColor, BlendMode.srcIn),
                      height: getHeight() * 0.02,
                    ),
                    SizedBox(width: getWidth() * 0.015),
                    CustomText(
                      text: al.estimated,
                      fontWeight: FontWeight.w400,
                      fontFamily: Assets.onsetRegular,
                      fontSize: 12,
                    ),
                  ],
                ),
                CustomText(
                  text: "0" + al.onlineUsers,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: Assets.onsetRegular,
                ),
              ],
            ),
            SizedBox(height: getHeight() * 0.025),

            CustomText(
              text: al.notificationAppearance,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: Assets.onsetMedium,
            ),
            SizedBox(height: getHeight() * 0.012),

            // Card 2
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(getWidth() * 0.04),
              decoration: BoxDecoration(
                color: AppColors.getPrimaryColorFromContext(context)
                    .withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.getPrimaryColorFromContext(context)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.offerIcon,
                    width: getWidth() * 0.085,
                    height: getHeight() * 0.039,
                    colorFilter: ColorFilter.mode(
                      AppColors.getPrimaryColorFromContext(context),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: getWidth() * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "${widget.data.reduction}%",
                          fontWeight: FontWeight.w600,
                          fontFamily: Assets.onsetSemiBold,
                          fontSize: 24,
                        ),
                        CustomText(
                          text: widget.data.title,
                          fontFamily: Assets.onsetMedium,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        CustomText(
                          text: widget.data.message,
                          fontFamily: Assets.onsetRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: getHeight() * 0.02),

            // Checkbox
            Row(
              children: [
                Checkbox(
                  value: saveTemplate,
                  onChanged: (val) =>
                      setState(() => saveTemplate = val ?? false),
                  activeColor: AppColors.getPrimaryColorFromContext(context),
                ),
                CustomText(
                  text: al.saveAsTemplate,
                  fontSize: 14,
                ),
              ],
            ),
            SizedBox(height: getHeight() * 0.025),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: al.backButton,
                    onTap: () => Navigator.pop(context),
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.blackColor,
                    textColor: AppColors.blackColor,
                  ),
                ),
                SizedBox(width: getWidth() * 0.04),
                Expanded(
                  child: CustomButton(
                    buttonText: al.sendNow,
                    onTap: () {

                      if (saveTemplate) {
                        final template = Template(
                          title: widget.data.title,
                          message: widget.data.message,
                          reduction: widget.data.reduction,
                        );
                        context.read<TemplateProvider>().addTemplate(template);
                      }

                      Navigator.pop(context);
                    },
                    backgroundColor:
                    AppColors.getPrimaryColorFromContext(context),
                    borderColor:
                    AppColors.getPrimaryColorFromContext(context),
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


