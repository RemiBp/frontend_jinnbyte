import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../appAssets/app_assets.dart';
import '../appColors/colors.dart';
import '../res/res.dart';
import 'custom_text.dart';

class RememberMeCheckBox extends StatefulWidget {
  final bool isChecked;
  final Color? activeColor;
  final double? fontSize;
  final String? text;
  final Function(bool?) onChanged;
  const RememberMeCheckBox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.activeColor,
    this.fontSize,
    this.text
  });

  @override
  State<RememberMeCheckBox> createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 0.85,
          child: Checkbox(
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            value: widget.isChecked,
            onChanged: widget.onChanged,
            activeColor: widget.activeColor?? AppColors.blackColor,
            checkColor: AppColors.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        SizedBox(height: getHeight() * 0.01),
        CustomText(
          text: widget.text?? "Remember me",
          fontSize: widget.fontSize?? sizes?.fontSize14,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        )
      ],
    );
  }
}

class TermsAndConditionsCheckbox extends StatelessWidget {
  final bool isChecked;
  final Function(bool?) onChanged;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;
  final FormFieldValidator<bool>? validator;

  const TermsAndConditionsCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.onTermsTap,
    required this.onPrivacyTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      // initialValue: isChecked,
      validator: validator,
      builder: (FormFieldState<bool> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 0.85,
                  child: Checkbox(
                    value: state.value ?? false,
                    onChanged: (value) {
                      onChanged(value);
                      state.didChange(value);
                    },
                    activeColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                SizedBox(height: getHeight() * 0.02),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: sizes?.fontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor,
                        fontFamily: Assets.onsetRegular,
                      ),
                      children: [
                        const TextSpan(text: "By signing up, you agree to our "),
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: sizes?.fontSize14,
                            fontWeight: FontWeight.w500,
                            fontFamily: Assets.onsetRegular,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: AppColors?.primaryColor,
                            fontSize: sizes?.fontSize14,
                            fontWeight: FontWeight.w500,
                            fontFamily: Assets.onsetRegular,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if(isChecked != true)
            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(left: getWidth() * 0.11),
                child: CustomText(
                  text:state.errorText!,
                  fontWeight: FontWeight.w400,
                  fontSize: sizes?.fontSize12,
                  color: AppColors.primaryColor,
                ),
              ),
          ],
        );
      },
    );
  }
}

