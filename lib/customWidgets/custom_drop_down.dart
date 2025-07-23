import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../appAssets/app_assets.dart';
import '../appColors/colors.dart';
import '../res/res.dart';
import 'custom_textfield.dart';

class CustomDropdown extends StatefulWidget {
  final List<DropdownMenuItem<int>> items;
  final String hintText;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;
  final FormFieldValidator<int>? validator;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.selectedValue,
    this.validator,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      validator: widget.validator,
      initialValue: widget.selectedValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<int> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField2<int>(
              value: widget.selectedValue,
              isExpanded: true,
              onChanged: (value) {
                widget.onChanged(value);
                state.didChange(value);
              },
              onMenuStateChange: (isOpenNow) {
                setState(() {
                  isOpen = isOpenNow;
                });
              },
              items: widget.items,
              style: TextStyle(
                fontFamily: Assets.onsetRegular,
                fontWeight: FontWeight.w400,
                fontSize: sizes?.fontSize16,
                color: AppColors.whiteColor,
              ),
              hint: Text(
                widget.hintText,
                style: TextStyle(
                  fontFamily: Assets.onsetRegular,
                  fontWeight: FontWeight.w400,
                  fontSize: sizes?.fontSize16,
                  color: AppColors.inputHintColor,
                ),
              ),
              decoration: InputDecoration(
                filled: false,
                // fillColor: AppColors.greyColor,
                contentPadding: EdgeInsets.only(
                  top: getHeightRatio() * 16,
                  bottom: getHeightRatio() * 16,
                  right: getWidthRatio() * 16,
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
              ),
              iconStyleData: IconStyleData(
                icon: Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up_sharp
                      : Icons.keyboard_arrow_down_sharp,
                  color: AppColors.inputHintColor,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                offset: const Offset(0, 0),
                maxHeight: getHeight() * 0.3,
              ),
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                  // color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(left: getWidthRatio() * 16),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(
                    fontFamily: Assets.onsetRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: sizes?.fontSize12,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}