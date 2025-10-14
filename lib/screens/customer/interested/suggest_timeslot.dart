import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/common_app_bar.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/res/res.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../appAssets/app_assets.dart';
import '../../../l18n.dart';
import '../../../res/toasts.dart';

class SuggestTimeSlotScreen extends StatefulWidget {
  const SuggestTimeSlotScreen({super.key});

  @override
  State<SuggestTimeSlotScreen> createState() => _SuggestTimeSlotScreenState();
}

class _SuggestTimeSlotScreenState extends State<SuggestTimeSlotScreen> {
  int selectedDateIndex = -1;
  int selectedTimeIndex = -1;
  DateTime? selectedDate;

  final List<Map<String, String>> dates = [
    {"day": "Mon", "date": "24"},
    {"day": "Tue", "date": "25"},
    {"day": "Wed", "date": "26"},
    {"day": "Thu", "date": "27"},
    {"day": "Fri", "date": "28"},
    {"day": "Sat", "date": "29"},
    {"day": "Sun", "date": "30"},
  ];

  final List<String> timeSlots = [
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
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Suggest a Time Slot"),

      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.all(sizes!.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min, // keeps it compact
          children: [
            //  Divider above button
            Divider(
              color: AppColors.greyBordersColor,
              thickness: 1,
              height: 1,
            ),

            SizedBox(height: getHeight() * 0.012), // small spacing after divider

            CustomButton(
              buttonText: al.continueText,
              onTap: () {
                if (selectedDateIndex == -1 && selectedDate == null) {
                  Toasts.getErrorToast(text: "Please select a date");
                  return;
                }
                if (selectedTimeIndex == -1) {
                  Toasts.getErrorToast(text: "Please select a time");
                  return;
                }
                context.push(Routes.selectFriendsRoute);

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
            SizedBox(height: getHeight() * 0.04),

            /// Header with right-aligned month chip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Select Date",
                  fontSize: sizes!.fontSize16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                      Toasts.getSuccessToast(
                        text:
                        "Selected: ${picked.day}/${picked.month}/${picked.year}",
                      );
                    }
                  },
                  child: _CalendarButton(
                    month: selectedDate != null
                        ? _monthAbbreviation(selectedDate!.month)
                        : "Jan",
                  ),
                ),
              ],
            ),

            SizedBox(height: getHeight() * 0.025),

            /// Date Chips
            SizedBox(
              height: 54,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final item = dates[index];
                  final bool isSelected = selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedDateIndex = index),
                    child: _DateChip(
                      day: item["day"]!,
                      date: item["date"]!,
                      isSelected: isSelected,
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: getHeight() * 0.04),

            /// Select Time
            CustomText(
              text: "Select Time",
              fontSize: sizes!.fontSize16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * 0.02),

            /// Time Chips - 3 per row
            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: List.generate(timeSlots.length, (index) {
                final isSelected = selectedTimeIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => selectedTimeIndex = index),
                  child: _TimeChip(
                    label: timeSlots[index],
                    isSelected: isSelected,
                  ),
                );
              }),
            ),

            SizedBox(height: getHeight() * 0.04),

            /// Message field
            CustomText(
              text: "Message",
              fontSize: sizes!.fontSize16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
            SizedBox(height: getHeight() * 0.01),
            Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyBordersColor),
              ),
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "e.g. Let’s try this Friday night...?",
                  hintStyle: TextStyle(
                    color: AppColors.inputHintColor,
                    fontSize: sizes!.fontSize14,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),

            SizedBox(height: getHeight() * 0.05),
          ],
        ),
      ),
    );
  }

  String _monthAbbreviation(int month) {
    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[month - 1];
  }
}

/// 🗓 Calendar Button (Month Selector)
class _CalendarButton extends StatelessWidget {
  final String month;
  const _CalendarButton({required this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyBordersColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.calendarIcon,
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(AppColors.blackColor,BlendMode.srcIn),
          ),
          const SizedBox(width: 4),
          CustomText(
            text: month,
            fontSize: sizes!.fontSize12,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}

/// 📅 Date Chip
class _DateChip extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;

  const _DateChip({
    required this.day,
    required this.date,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 54,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.getPrimaryColorFromContext(context)
            : AppColors.greyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: day,
            fontSize: sizes!.fontSize11,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
          ),
          CustomText(
            text: date,
            fontSize: sizes!.fontSize12,
            fontWeight: FontWeight.w700,
            color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}

/// ⏰ Time Chip
/// ⏰ Time Chip
class _TimeChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _TimeChip({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95, // ✅ Reduced width so 3 chips fit per row
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.getPrimaryColorFromContext(context)
            : AppColors.greyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomText(
        text: label,
        fontSize: sizes!.fontSize12,
        fontWeight: FontWeight.w500,
        color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
        textAlign: TextAlign.center,
      ),
    );
  }
}
