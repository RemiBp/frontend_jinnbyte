import 'package:flutter/material.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';
import 'customer_maps_widgets.dart';

class LeisureBottomSheet extends StatefulWidget {
  const LeisureBottomSheet({super.key});

  @override
  State<LeisureBottomSheet> createState() => _LeisureBottomSheetState();
}

class _LeisureBottomSheetState extends State<LeisureBottomSheet> {
  double distance = 20;
  List<String> cuisines = ["Theater", "Comedy", "Club", "Concert Hall"];
  List<String> events = ["Concert", "One-man Show", "Circus"];
  List<String> selectedCuisines = ["Theater"];
  List<String> selectedEvents = ["Concert"];



  final List<Map<String, dynamic>> filters = [
    {"id": 1, "title": "Intense"},
    {"id": 2, "title": "Moving"},
    {"id": 3, "title": "Captivating"},
    {"id": 4, "title": "Enriching"},
    {"id": 5, "title": "Profound"},
  ];



  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Filters",
                    color: AppColors.blackColor,
                    fontSize: sizes?.fontSize18,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: AppColors.blackColor,
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),

              // Content
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  children: [
                    const CustomSectionTitle(title: "Distance"),
                    Row(
                      children: [
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: getHeightRatio() * 10,
                              activeTrackColor: AppColors.userPrimaryColor,
                              inactiveTrackColor: AppColors.greyColor,
                              thumbColor: AppColors.whiteColor,
                              overlayColor: AppColors.userPrimaryColor.withAlpha(40),
                              valueIndicatorColor: AppColors.userPrimaryColor,
                            ),
                            child: Slider(
                              value: distance,
                              min: 10,
                              max: 100,
                              divisions: 5,
                              label: "${distance.round()} km",
                              onChanged: (val) => setState(() => distance = val),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const CustomSectionTitle(title: "Venue"),
                    Column(
                      children: cuisines.map((c) {
                        final selected = selectedCuisines.contains(c);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CustomMultiSelectOption(
                            label: c,
                            selected: selected,
                            onTap: () {
                              setState(() {
                                if (selected) {
                                  selectedCuisines.remove(c);
                                } else {
                                  selectedCuisines.add(c);
                                }
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: getHeight() * 0.01),
                    const CustomSectionTitle(title: "Event"),
                    Column(
                      children: events.map((c) {
                        final selected = selectedEvents.contains(c);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CustomMultiSelectOption(
                            label: c,
                            selected: selected,
                            onTap: () {
                              setState(() {
                                if (selected) {
                                  selectedEvents.remove(c);
                                } else {
                                  selectedEvents.add(c);
                                }
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: getHeight() * 0.01),
                    const CustomSectionTitle(title: "Emotional Impact"),
                  Wrap(
                    spacing: 8, // horizontal gap
                    runSpacing: 0, // vertical gap between rows
                    children: List.generate(filters.length, (index) {
                      final isSelected = selectedFilterIndex == index;

                      return FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: filters[index]["title"],
                              color: isSelected
                                  ? AppColors.userPrimaryColor
                                  : AppColors.blackColor,
                              fontSize: sizes?.fontSize12,
                              fontWeight: FontWeight.w500,
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.close,
                                size: 16,
                                color: AppColors.userPrimaryColor,
                              ),
                            ],
                          ],
                        ),
                        selected: isSelected,
                        backgroundColor: AppColors.greyColor, // default grey
                        selectedColor: AppColors.userPrimaryColor.withOpacity(0.15), // light blue look
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide.none, // no border
                        ),
                        onSelected: (_) {
                          setState(() {
                            selectedFilterIndex = isSelected ? -1 : index; // toggle
                          });
                        },
                      );
                    }),
                  ),

                  SizedBox(height: getHeight() * 0.02),
                  ],
                ),
              ),

              // Footer buttons
              SizedBox(height: getHeight() * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    buttonText: 'Reset All',
                    onTap: () {
                      Navigator.pop(context);
                    },
                    buttonWidth: getWidth() * .43,
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.blackColor,
                    textColor: AppColors.blackColor,
                    textFontWeight: FontWeight.w700,
                  ),
                  CustomButton(
                    buttonText: 'Apply Filters',
                    onTap: () {

                    },
                    buttonWidth: getWidth() * .43,
                    backgroundColor: AppColors.userPrimaryColor,
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.w700,
                  ),
                ],
              ),
              // SizedBox(height: getHeightRatio() * 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRatingRow(String title, int selected, Function(int) onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSectionTitle(title: title),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyBordersColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(6, (index) {
              bool isSelected = selected == index;

              // "Any" button
              if (index == 0) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onSelected(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.userPrimaryColor : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                      ),
                      child: CustomText(
                        text: "Any",
                        color: isSelected ? Colors.white : AppColors.inputHintColor,
                        fontSize: sizes?.fontSize14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }

              // Star rating buttons
              return Expanded(
                child: GestureDetector(
                  onTap: () => onSelected(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.userPrimaryColor : Colors.transparent,
                      border: Border(
                        left: BorderSide(color: AppColors.greyBordersColor),
                      ),
                      borderRadius: index == 5
                          ? const BorderRadius.horizontal(right: Radius.circular(8))
                          : BorderRadius.zero,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, size: 18, color: Colors.orange),
                        const SizedBox(width: 4),
                        CustomText(
                          text: "$index",
                          color: isSelected ? Colors.white : AppColors.inputHintColor,
                          fontSize: sizes?.fontSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
