import 'package:flutter/material.dart';

import '../appAssets/app_assets.dart';
import '../appColors/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool isExpanded;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final Alignment? alignment;
  final TextOverflow? textOverflow;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final int? lines;
  final bool? giveLinesAsText;
  final Color? decorationColor;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.alignment,
    this.isExpanded = false,
    this.fontFamily,
    this.textOverflow,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
    this.lines,
    this.giveLinesAsText, this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: isExpanded ? MediaQuery.of(context).size.width : null,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? Colors.black,
          fontFamily: fontFamily ?? Assets.onsetRegular,
          decoration: textDecoration,
          decorationColor:decorationColor?? AppColors.primaryColor,
        ),
        overflow:
            giveLinesAsText == true
                ? null
                : textOverflow ?? TextOverflow.ellipsis,
        maxLines: lines,
      ),
    );
  }
}
