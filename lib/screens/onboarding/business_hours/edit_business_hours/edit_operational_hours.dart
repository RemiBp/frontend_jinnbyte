import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/blurry_back_ground.dart';
import '../../../../customWidgets/common_app_bar.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../l18n.dart';
import '../../../../res/res.dart';
import '../../../../res/toasts.dart';
import '../../../../screens/restaurant/profile/profile_provider.dart';
import '../widgets/setup_time_popup.dart';

class EditOperationalHours extends StatefulWidget {
  final List<dynamic>? operationalHoursList;
  final bool fromSettings;

  const EditOperationalHours({
    super.key,
    this.operationalHoursList,
    this.fromSettings = false,
  });

  @override
  State<EditOperationalHours> createState() => _EditOperationalHoursState();
}

class _EditOperationalHoursState extends State<EditOperationalHours> {
  // late OperationalHoursProvider operationalHoursProvider;
  // late ProfileProvider profileProvider;
  bool isSelectAll = false;
  bool isInfoOpened = true;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    for (var day in days) {
      isActive[day] = false;
      startTimes[day] = const TimeOfDay(hour: 0, minute: 0);
      endTimes[day] = const TimeOfDay(hour: 0, minute: 0);
    }

    for (var item in widget.operationalHoursList ?? []) {
      final String day = item.day;
      final bool isClosed = item.isClosed ?? true;
      final start = item.startTime ?? "00:00";
      final end = item.endTime ?? "00:00";

      isActive[day] = !isClosed;
      startTimes[day] = _parseTime(start);
      endTimes[day] = _parseTime(end);
    }

    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    profileProvider.init(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.fromSettings) {
        profileProvider.getProducerOperationalHours();
      }
    });
  }

  TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  final List<String> days = [
    al.monday,
    al.tuesday,
    al.wednesday,
    al.thursday,
    al.friday,
    al.saturday,
    al.sunday,
  ];

  final Map<String, bool> isActive = {};
  final Map<String, TimeOfDay> startTimes = {};
  final Map<String, TimeOfDay> endTimes = {};

  Future<void> pickTime(String day, bool isStart) async {
    final initialTime = isStart ? startTimes[day]! : endTimes[day]!;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      // Convert picked time to 24-hour formatted string for easy comparison
      final now = DateTime.now();
      final pickedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      final pickedFormatted = DateFormat(
        'HH:mm',
      ).format(pickedDateTime); // 12:00 AM = 00:00 in 24-hour format
      if (!isStart && pickedFormatted == "00:00") {
        Toasts.getErrorToast(text: al.closingTimeCannotBeMidnight);
        return;
      } // Define 11:59 PM as the latest possible time
      const maxEndTime = TimeOfDay(hour: 23, minute: 59);
      int pickedMinutes = picked.hour * 60 + picked.minute;
      int maxMinutes = maxEndTime.hour * 60 + maxEndTime.minute;
      if (!isStart && pickedMinutes > maxMinutes) {
        Toasts.getErrorToast(text: al.closingTimeCannotBeAfter1159);
        return;
      } // Disallow closing time before or equal to opening time
      if (!isStart) {
        int startMinutes = startTimes[day]!.hour * 60 + startTimes[day]!.minute;
        if (pickedMinutes <= startMinutes) {
          Toasts.getErrorToast(text: al.closingTimeMustBeAfterOpening);
          return;
        }
      }
      setState(() {
        if (isStart) {
          startTimes[day] = picked;
        } else {
          endTimes[day] = picked;
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

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: al.businessHours,
        showEditButton: widget.fromSettings,
        onEdit: () {
          setState(() {
            isEditMode = true;
          });
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding,
          vertical: getHeight() * 0.01,
        ),
        child:
            (!widget.fromSettings || isEditMode)
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getHeightRatio() * 16),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isInfoOpened = !isInfoOpened; // toggle
                        });
                      },
                      child: Row(
                        children: [
                          CustomText(
                            text: al.setWeeklyAvailability,
                            fontSize: sizes?.fontSize18,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(width: getWidth() * 0.02),
                          Image.asset(
                            Assets.infoIcon,
                            height: getHeight() * 0.02,
                            color: AppColors.getPrimaryColorFromContext(
                              context,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getHeight() * 0.01),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState:
                          isInfoOpened
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                      firstChild: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sizes!.pagePadding,
                          vertical: getHeight() * 0.02,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.getPrimaryColorFromContext(context),
                        ),
                        child: CustomText(
                          text: al.weeklyAvailabilityDescription,
                          fontSize: sizes?.fontSize12,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          giveLinesAsText: true,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      secondChild:
                          const SizedBox.shrink(), // when hidden, collapse space
                    ),

                    SizedBox(height: getHeightRatio() * 16),
                    Row(
                      children: [
                        Transform.translate(
                          offset: Offset(-getWidth() * 0.02, 0),
                          child: Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: isSelectAll,
                              onChanged: (val) {
                                if (val) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BlurryBackground(
                                        child: SetupTimePopup(
                                          onConfirm: (
                                            TimeOfDay start,
                                            TimeOfDay end,
                                          ) {
                                            // Convert times for comparison
                                            int startMinutes =
                                                start.hour * 60 + start.minute;
                                            int endMinutes =
                                                end.hour * 60 + end.minute;

                                            //  Validate closing time not 12:00 AM
                                            if (end.hour == 0 &&
                                                end.minute == 0) {
                                              Toasts.getErrorToast(
                                                text:
                                                    al.closingTimeCannotBeMidnight,
                                              );
                                              return;
                                            }

                                            //  Validate closing time after opening time
                                            if (endMinutes <= startMinutes) {
                                              Toasts.getErrorToast(
                                                text:
                                                    al.closingTimeMustBeAfterOpening,
                                              );
                                              return;
                                            }

                                            //  (Optional) Validate max end time 11:59 PM
                                            if (endMinutes > (23 * 60 + 59)) {
                                              Toasts.getErrorToast(
                                                text:
                                                    al.closingTimeCannotBeAfter1159,
                                              );
                                              return;
                                            }

                                            // Apply times only if valid
                                            setState(() {
                                              isSelectAll = true;
                                              for (final day in days) {
                                                isActive[day] = true;
                                                startTimes[day] = start;
                                                endTimes[day] = end;
                                              }
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    isSelectAll = false;
                                  });
                                }
                              },
                              // activeThumbColor: AppColors.whiteColor,
                              activeTrackColor:
                                  AppColors.getPrimaryColorFromContext(context),
                              inactiveThumbColor: AppColors.whiteColor,
                              inactiveTrackColor: AppColors.greyColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                        CustomText(
                          text: al.selectForAllDay,
                          fontSize: sizes?.fontSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: getHeightRatio() * 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: al.dayOnOff,
                            fontSize: sizes?.fontSize12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                            lines: 1,
                          ),
                        ),
                        SizedBox(width: getWidth() * 0.009),
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth() * 0.22,
                              child: CustomText(
                                text: al.startTime,
                                fontSize: sizes?.fontSize12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            SizedBox(width: getWidth() * 0.02),
                            SizedBox(
                              width: getWidth() * 0.22,
                              child: CustomText(
                                text: al.endTime,
                                fontSize: sizes?.fontSize12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: getHeightRatio() * 16),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ...days.map((day) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                              ),
                              child: Row(
                                children: [
                                  Transform.translate(
                                    offset: Offset(-getWidth() * 0.02, 0),
                                    child: Transform.scale(
                                      scale: 0.8,
                                      child: Switch(
                                        value: isActive[day]!,
                                        onChanged: (val) {
                                          setState(() {
                                            isActive[day] = val;
                                          });
                                        },
                                        // activeThumbColor: AppColors.whiteColor,
                                        activeTrackColor:
                                            AppColors.getPrimaryColorFromContext(
                                              context,
                                            ),
                                        inactiveThumbColor:
                                            AppColors.whiteColor,
                                        inactiveTrackColor: AppColors.greyColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      text: day.substring(0, 3),
                                      fontSize: sizes?.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      // color: isActive[day]!?AppColors.whiteColor:AppColors.getPrimaryColorFromContext(context),
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  SizedBox(width: getWidth() * 0.009),
                                  if (isActive[day]!)
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => pickTime(day, true),
                                          child: Container(
                                            width: getWidth() * 0.22,
                                            padding: EdgeInsets.only(
                                              top: getHeight() * 0.015,
                                              bottom: getHeight() * 0.015,
                                              left: getWidth() * 0.025,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.greyColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: CustomText(
                                              text: formatTime(
                                                startTimes[day]!,
                                              ),
                                              fontSize: sizes?.fontSize14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: getWidth() * 0.02),
                                        InkWell(
                                          onTap: () => pickTime(day, false),
                                          child: Container(
                                            width: getWidth() * 0.22,
                                            padding: EdgeInsets.only(
                                              top: getHeight() * 0.015,
                                              bottom: getHeight() * 0.015,
                                              left: getWidth() * 0.025,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.greyColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: CustomText(
                                              text: formatTime(endTimes[day]!),
                                              fontSize: sizes?.fontSize14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Container(
                                      width: getWidth() * 0.46,
                                      padding: EdgeInsets.only(
                                        top: getHeight() * 0.015,
                                        bottom: getHeight() * 0.015,
                                        left: getWidth() * 0.025,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.greyColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: CustomText(
                                        text: al.closed,
                                        fontSize: sizes?.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primarySlateColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: getHeight() * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          buttonText: al.cancel,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          buttonWidth: getWidth() * .42,
                          backgroundColor: Colors.transparent,
                          borderColor: AppColors.blackColor,
                          textColor: AppColors.blackColor,
                          textFontWeight: FontWeight.w700,
                        ),
                        CustomButton(
                          buttonText: al.saveChanges,
                          onTap: () async {
                            // Check if at least one day is selected
                            bool hasAnyActiveDay = isActive.values.any(
                              (isDayActive) => isDayActive,
                            );

                            if (!hasAnyActiveDay) {
                              Toasts.getErrorToast(
                                text: al.pleaseSelectAtLeastOneDay,
                              );
                              return;
                            }

                            final provider = Provider.of<ProfileProvider>(
                              context,
                              listen: false,
                            );
                            final success = await provider.setOperationalHours(
                              days: days,
                              isActive: isActive,
                              startTimes: startTimes,
                              endTimes: endTimes,
                            );

                            if (success && mounted) {
                              context.push(Routes.galleryViewRoute);
                            }
                          },
                          buttonWidth: getWidth() * .42,
                          backgroundColor: AppColors.getPrimaryColorFromContext(
                            context,
                          ),
                          borderColor: Colors.transparent,
                          textColor: Colors.white,
                          textFontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(height: getHeightRatio() * 16),
                  ],
                )
                : profileProvider.getProducerOperationalHoursResponse != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getHeightRatio() * 16),
                          CustomText(
                            text: al.businessHours,
                            fontSize: sizes?.fontSize18,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: getHeightRatio() * 16),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: profileProvider.getProducerOperationalHoursResponse!.data.length,
                              itemBuilder: (context, index) {
                                final operationalHour = profileProvider.getProducerOperationalHoursResponse!.data[index];
                                final day = operationalHour.day ?? '';
                                final startTime = operationalHour.startTime;
                                final endTime = operationalHour.endTime;
                                final isClosed = operationalHour.isClosed ?? true;
                                
                                String displayText;
                                if (isClosed || startTime == null || endTime == null) {
                                  displayText = al.closed;
                                } else {
                                  // Convert 24-hour format to 12-hour format
                                  displayText = _formatTimeDisplay(startTime, endTime);
                                }
                                
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: '$day:',
                                        fontSize: sizes?.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackColor,
                                      ),
                                      CustomText(
                                        text: displayText,
                                        fontSize: sizes?.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: isClosed ? AppColors.primarySlateColor : AppColors.blackColor,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Container(),
      ),
    );
  }

  String _formatTo24Hour(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  String _formatTimeDisplay(String startTime, String endTime) {
    try {
      // Parse 24-hour format times
      final startParts = startTime.split(':');
      final endParts = endTime.split(':');
      
      final startHour = int.parse(startParts[0]);
      final startMinute = int.parse(startParts[1]);
      final endHour = int.parse(endParts[0]);
      final endMinute = int.parse(endParts[1]);
      
      // Convert to 12-hour format
      String startPeriod = startHour >= 12 ? 'PM' : 'AM';
      String endPeriod = endHour >= 12 ? 'PM' : 'AM';
      
      int startHour12 = startHour == 0 ? 12 : (startHour > 12 ? startHour - 12 : startHour);
      int endHour12 = endHour == 0 ? 12 : (endHour > 12 ? endHour - 12 : endHour);
      
      String startMinuteStr = startMinute.toString().padLeft(2, '0');
      String endMinuteStr = endMinute.toString().padLeft(2, '0');
      
      return '$startHour12:$startMinuteStr $startPeriod - $endHour12:$endMinuteStr $endPeriod';
    } catch (e) {
      debugPrint('Error formatting time: $e');
      return '$startTime - $endTime';
    }
  }
}
