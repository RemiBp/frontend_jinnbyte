import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../appAssets/app_assets.dart';
import '../appColors/colors.dart';
import '../res/res.dart';

class TextFieldLabel extends StatelessWidget {
  final String? label;
  const TextFieldLabel({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getHeightRatio() * 6),
      child: RichText(
        text:  TextSpan(
          children: [
            TextSpan(
              text: label,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: sizes?.fontSize14,
                  fontFamily: Assets.onsetRegular,
                  color: Colors.black,
              ),
            ),
            TextSpan(
              text: "*",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: sizes?.fontSize14,
                fontFamily:Assets.onsetRegular,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
