import 'package:flutter/material.dart';
import '../res/res.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isBorder;
  final Color btnBgColor;
  final Color textColor;

  const CommonButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isBorder,
    required this.btnBgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnBgColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isBorder
              ? const BorderSide(color: Colors.black, width: 1)
              : BorderSide.none,
        ),
        fixedSize: Size(getWidth() * .42, getHeight() * .06),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: sizes?.fontSize16,
          color: textColor,
        ),
      ),
    );
  }
}
