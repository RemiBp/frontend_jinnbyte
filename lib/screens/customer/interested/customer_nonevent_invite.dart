import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../l18n.dart';
import 'interestedWidgets/time_slot_widgets.dart';

class CustomerNonEventInvite extends StatefulWidget {
  const CustomerNonEventInvite({super.key});

  @override
  State<CustomerNonEventInvite> createState() => _CustomerNonEventInviteState();
}

class _CustomerNonEventInviteState extends State<CustomerNonEventInvite> {
  bool showMore = false;
  int selectedRadio = -1;
  int selectedDate = -1;
  int selectedTime = -1;

  final TextEditingController messageController = TextEditingController();

  final List<Map<String, String>> dates = [
    {"day": "Mon", "date": "24"},
    {"day": "Tue", "date": "25"},
    {"day": "Wed", "date": "26"},
    {"day": "Thu", "date": "27"},
    {"day": "Fri", "date": "28"},
  ];

  final List<String> times = [
    "11AM-12AM",
    "12AM-1PM",
    "1PM-2PM",
    "2PM-3PM",
    "3PM-4PM",
    "5PM-6PM",
    "7PM-8PM",
    "9PM-10PM",
    "10PM-11PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      // Bottom Confirm Button
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

            CustomButton(
              buttonText: al.confirm,
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

      // AppBar with Divider
      appBar: CommonAppBar(title: "Lorem Ipsum"),


      // Body
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding,
          vertical: getHeight() * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event info
            CustomText(
              text: "Flavors of the Season",
              fontSize: sizes?.fontSize18,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * 0.012),

            // Calendar Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BlueIconContainer(svgPath: Assets.calendarIcon),
                SizedBox(width: getWidth() * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "${al.monday}, ${al.june} 28, 2025",
                        fontFamily: Assets.onsetMedium,
                        fontSize: sizes?.fontSize14,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: "08:00 PM - 11:00 PM",
                        fontFamily: Assets.onsetRegular,
                        fontSize: sizes?.fontSize12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight() * 0.012),

            // Location Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, //  centers with both text lines
              children: [
                _BlueIconContainer(svgPath: Assets.locationIcon),
                SizedBox(width: getWidth() * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Rivoli, Paris, France",
                        fontFamily: Assets.onsetMedium,
                        fontSize: sizes?.fontSize14,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: getHeight() * 0.004),
                      CustomText(
                        text: "12 Rue de Rivoli, 75001 Paris, France",
                        fontFamily: Assets.onsetRegular,
                        fontSize: sizes?.fontSize12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight() * 0.03),

            // Suggested Time
            CustomText(
              text: al.suggestedTime,
              fontSize: sizes?.fontSize15,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * 0.015),

            // Radio Button Cards
            Column(
              children: [
                _buildRadioCard(
                  value: 0,
                  label: "Aug 28, 10:00 AM - 11:00 AM",
                ),
                SizedBox(height: getHeight() * 0.015),
                _buildRadioCard(
                  value: 1,
                  label: al.suggestNewTime,
                ),
              ],
            ),

            // Expansion
            AnimatedCrossFade(
              crossFadeState: selectedRadio == 1
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
              firstChild: const SizedBox.shrink(),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getHeight() * 0.03),

                  // Select Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: al.selectDate,
                        fontSize: sizes?.fontSize15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                      const CalendarButton(month: "Jan"),
                    ],
                  ),
                  SizedBox(height: getHeight() * 0.02),

                  // Date Chips
                  SizedBox(
                    height: getHeight() * 0.07,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: getWidth() * 0.03),
                      itemBuilder: (_, index) {
                        final date = dates[index];
                        return DateChip(
                          day: date["day"]!,
                          date: date["date"]!,
                          isSelected: selectedDate == index,
                          onTap: () => setState(() => selectedDate = index),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.03),

                  // Select Time
                  CustomText(
                    text: al.selectTime,
                    fontSize: sizes?.fontSize15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(height: getHeight() * 0.015),

                  // Time Chips
                  Wrap(
                    spacing: getWidth() * 0.03,
                    runSpacing: getHeight() * 0.012,
                    children: List.generate(times.length, (i) {
                      return TimeChip(
                        label: times[i],
                        isSelected: selectedTime == i,
                        onTap: () => setState(() => selectedTime = i),
                      );
                    }),
                  ),
                  SizedBox(height: getHeight() * 0.03),

                  // Message field
                  CustomText(
                    text: al.message,
                    fontSize: sizes?.fontSize15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(height: getHeight() * 0.015),
                  MessageField(controller: messageController),
                  SizedBox(height: getHeight() * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Blue circular icon container with SVG inside
  Widget _BlueIconContainer({required String svgPath}) {
    return Container(
      width: getHeight() * 0.04,
      height: getHeight() * 0.04,
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColorFromContext(context).withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          height: getHeight() * 0.02,
          colorFilter: ColorFilter.mode(
              AppColors.getPrimaryColorFromContext(context), BlendMode.srcIn),
        ),
      ),
    );
  }

  // Clean radio card (with shadow + proper horizontal alignment)
  Widget _buildRadioCard({required int value, required String label}) {
    final bool isSelected = selectedRadio == value;

    return Padding(
      padding: EdgeInsets.symmetric( //  keeps alignment consistent
        horizontal: 0,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedRadio = (selectedRadio == value) ? -1 : value;
            showMore = (selectedRadio == 1);
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: EdgeInsets.only(top: getHeight() * 0.002), // subtle spacing
          padding: EdgeInsets.symmetric(
            horizontal: getWidth() * 0.045,
            vertical: getHeight() * 0.018,
          ),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomText(
                  text: label,
                  fontSize: sizes?.fontSize14,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off_outlined,
                color: isSelected
                    ? AppColors.getPrimaryColorFromContext(context)
                    : AppColors.inputHintColor,
                size: getHeight() * 0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
