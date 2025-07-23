
import 'package:choice_app/appColors/colors.dart';
import 'package:flutter/material.dart';

import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';


class SetupTimePopup extends StatefulWidget {
  final void Function(TimeOfDay start, TimeOfDay end) onConfirm;

  const SetupTimePopup({
    super.key,
    required this.onConfirm,
  });

  @override
  State<SetupTimePopup> createState() => _SetupTimePopupState();
}

class _SetupTimePopupState extends State<SetupTimePopup> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  void initState() {
    super.initState();
    // Default values – can be replaced with initial values passed via constructor
    startTime = const TimeOfDay(hour: 0, minute: 0);
    endTime = const TimeOfDay(hour: 0, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      insetPadding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding, vertical: getHeight() * 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding, vertical: getHeight() * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Start Time",
                        fontSize: sizes?.fontSize12,
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () => pickTime(true),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: getHeight() * 0.015, horizontal: getWidth() * 0.025),
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomText(
                            text: formatTime(startTime!),
                            fontSize: sizes?.fontSize14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "End Time",
                        fontSize: sizes?.fontSize12,
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () => pickTime(false),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: getHeight() * 0.015, horizontal: getWidth() * 0.025),
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomText(
                            text: formatTime(endTime!),
                            fontSize: sizes?.fontSize14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight() * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  buttonText: 'Cancel',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  buttonWidth: getWidth() * .35,
                  backgroundColor: Colors.transparent,
                  borderColor: AppColors.blackColor,
                  textColor: AppColors.blackColor,
                  textFontWeight: FontWeight.w700,
                ),
                CustomButton(
                  buttonText: '"Set Up Time"',
                  onTap: () {
                    widget.onConfirm(startTime!, endTime!);
                    Navigator.pop(context);
                  },
                  buttonWidth: getWidth() * .35,
                  backgroundColor: AppColors.getPrimaryColorFromContext(context),
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  textFontWeight: FontWeight.w700,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickTime(bool isStart) async {
    final TimeOfDay initial = isStart ? startTime! : endTime!;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
