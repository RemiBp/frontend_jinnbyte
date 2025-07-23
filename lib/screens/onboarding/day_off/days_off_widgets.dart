import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../res/res.dart';
import '../slot_management/slot_management_view.dart';

class DatePickerTile extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final InputDecoration? decoration;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;

  const DatePickerTile({
    super.key,
    this.controller,
    this.hintText = 'Password',
    this.obscureText = true,
    this.decoration,
    this.onChanged,
    this.validator,
  });

  @override
  State<DatePickerTile> createState() =>
      _DatePickerTileState();
}

class _DatePickerTileState extends State<DatePickerTile> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: TextStyle(
        fontFamily: Assets.onsetRegular,
        fontWeight: FontWeight.w400,
        fontSize: sizes?.fontSize16,
        color: AppColors.blackColor,
      ),
      decoration: widget.decoration ??
          InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: getWidthRatio() * 16, vertical: getHeightRatio() * 16),
              hintText: widget.hintText,
              filled: false,
              // fillColor: AppColors.greyColor,
              hintStyle: TextStyle(
                fontFamily: Assets.onsetRegular,
                fontWeight: FontWeight.w400,
                fontSize: sizes?.fontSize16,
                color: AppColors.inputHintColor,
              ),
              border: buildOutlineInputBorder(AppColors.greyBordersColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.greyBordersColor)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.greyBordersColor)
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.greyBordersColor)
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.greyBordersColor)
              ),
              errorStyle: TextStyle(
                fontFamily: Assets.onsetRegular,
                fontWeight: FontWeight.w400,
                fontSize: sizes?.fontSize12,
                color: Colors.red,
              ),
              suffixIcon: IconButton(
                icon: Image.asset(
                    Assets.calenderIcon,
                    width: getWidthRatio() * 16,
                    height: getHeightRatio() * 16,
                    fit: BoxFit.fill,
                    color: AppColors.greyBordersColor
                ),
                onPressed: (){},
              )
          ),
    );
  }
}

class ChipGroupMultiSelect extends StatefulWidget {
  final List<Slots> options;
  final void Function(List<Slots>) onSelectionChanged;
  final List<Slots>? initialSelection;
  final EdgeInsets? chipPadding;

  const ChipGroupMultiSelect({
    super.key,
    required this.options,
    required this.onSelectionChanged,
    this.initialSelection,
    this.chipPadding,
  });

  @override
  State<ChipGroupMultiSelect> createState() => _ChipGroupMultiSelectState();
}

class _ChipGroupMultiSelectState extends State<ChipGroupMultiSelect> {
  late List<Slots> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = widget.initialSelection ?? [];
  }

  @override
  void didUpdateWidget(covariant ChipGroupMultiSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedOptions = widget.initialSelection ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.options.map((option) {
        return SelectableChip(
          label: option,
          isSelected: selectedOptions.contains(option),
          onTap: () {
            setState(() {
              if (selectedOptions.contains(option)) {
                selectedOptions.remove(option); // Deselect
              } else {
                selectedOptions.add(option); // Select
              }
              widget.onSelectionChanged(selectedOptions);
            });
          },
        );
      }).toList(),
    );
  }
}

class SelectableChip extends StatelessWidget {
  final Slots label;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  const SelectableChip({
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
        width: getWidth() * 0.43,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 0,
              vertical: getHeightRatio() * 16,
            ),
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
              text:
              "${convertToCompactAmPm(label.startTime ?? "")} - ${convertToCompactAmPm(label.endTime ?? "")}",
              fontSize: sizes?.fontSize12,
              color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
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
