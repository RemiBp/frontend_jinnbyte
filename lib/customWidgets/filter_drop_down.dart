import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../appColors/colors.dart';
import '../res/res.dart';
import 'custom_text.dart';

class FilterDropDown extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final String? selectedValue;
  final Color? bfColor;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  const FilterDropDown({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.selectedValue,
    this.validator,
    this.bfColor,
  });

  @override
  State<FilterDropDown> createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      validator: widget.validator,
      value: widget.selectedValue,
      isExpanded: true,
      onChanged: widget.onChanged,
      onMenuStateChange: (isOpenNow) {
        setState(() {
          isOpen = isOpenNow;
        });
      },
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child:CustomText(
            text: value,
            fontWeight: FontWeight.w500,
            fontSize: sizes?.fontSize12,
            lines: 1,
            textOverflow: TextOverflow.ellipsis,
            color: AppColors.inputHintColor,
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        // filled: true,
        // fillColor: widget.bfColor ?? AppColors.primarySlateColor,
        contentPadding: EdgeInsets.symmetric(horizontal: getWidth() * 0.02),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.greyBordersColor)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.greyBordersColor)
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.greyBordersColor)
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.greyBordersColor)
        ),
      ),
      buttonStyleData: ButtonStyleData(
        // height: 36,
        width: MediaQuery.of(context).size.width * 0.2,
        padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.02),
        decoration: BoxDecoration(
          // color: widget.bfColor ?? Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          isOpen ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp,
          color: AppColors.inputHintColor,
        ),
        // iconSize: getWidth() * 0.03,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: getHeight() * 0.2,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: widget.bfColor??AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        offset: const Offset(0, 0), // ensures dropdown opens directly below
      ),
      menuItemStyleData: const MenuItemStyleData(
        // padding: EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
