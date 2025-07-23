import 'package:choice_app/screens/onboarding/slot_management/slot_management_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/terms_and_conditions_check_box.dart';
import '../../../res/res.dart';

class EditDaysTile extends StatelessWidget {
  final String? label;
  final bool? isChecked;
  final bool? isEdit;
  final Function onSelectAll;

  const EditDaysTile({
    super.key,
    this.label,
    this.isChecked,
    this.isEdit,
    required this.onSelectAll
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label??"Monday",
          fontSize: sizes?.fontSize14,
          fontWeight: FontWeight.w500,
          lines: 1,
          textOverflow: TextOverflow.ellipsis,
          color:AppColors.blackColor,
        ),
        // if(isEdit??false)
          RememberMeCheckBox(
            isChecked: isChecked??false,
            text: "Select All",
            fontSize: sizes?.fontSize16,
            activeColor: AppColors.getPrimaryColorFromContext(context),
            onChanged: (bool? value) {
              onSelectAll();
            },
          ),
      ],
    );
  }
}


class MultiSlotSelection extends StatefulWidget {
  final List<Slots> options;
  final void Function(List<Slots>) onSelectionChanged;
  final List<Slots>? initialSelection;
  final EdgeInsets? chipPadding;
  final bool? isEdit;

  const MultiSlotSelection({
    super.key,
    required this.options,
    required this.onSelectionChanged,
    this.initialSelection,
    this.chipPadding,
    this.isEdit,
  });

  @override
  State<MultiSlotSelection> createState() => _ChipGroupMultiSelectState();
}

class _ChipGroupMultiSelectState extends State<MultiSlotSelection> {
  late List<Slots> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = widget.initialSelection ?? [];
  }


  @override
  void didUpdateWidget(covariant MultiSlotSelection oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedOptions = widget.initialSelection ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.options.map((option) {
        return SlotsChip(
          label: option,
          isSelected: selectedOptions.contains(option),
          // padding: widget.chipPadding,
          onTap: () {
            if(widget.isEdit??false){
              setState(() {
                if (selectedOptions.contains(option)) {
                  selectedOptions.remove(option); // Deselect
                } else {
                  selectedOptions.add(option); // Select
                }
                widget.onSelectionChanged(selectedOptions);
              });
            }
          },
        );
      }).toList(),
    );
  }
}



class SlotsChip extends StatelessWidget {
  final Slots label;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  const SlotsChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: getWidthRatio() * 150,
        width: getWidth() * 0.44,
        padding:
        padding ?? EdgeInsets.symmetric(horizontal: 0, vertical: getHeightRatio() * 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.getPrimaryColorFromContext(context)
              : AppColors.greyColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "${convertToCompactAmPm(label.startTime??"")} - ${convertToCompactAmPm(label.endTime??"")}",
              fontSize: sizes?.fontSize12,
              color: isSelected?AppColors.whiteColor:AppColors.blackColor,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String convertToCompactAmPm(String time24) {
    final parsedTime = DateFormat("HH:mm").parse(time24);
    return DateFormat("hh:mm a").format(parsedTime);
  }
}