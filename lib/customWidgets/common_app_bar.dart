import 'package:flutter/material.dart';
import '../appAssets/app_assets.dart';
import '../appColors/colors.dart';
import '../res/res.dart';
import 'custom_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackArrow;
  final bool? showEditButton;
  final bool? hideBottomBorder;
  final Function? onEdit;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBackArrow = true,
    this.showEditButton,
    this.hideBottomBorder,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (showBackArrow)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.blackColor,),
              onPressed: () => Navigator.pop(context),
            ),
          Expanded(
            child: CustomText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: sizes?.fontSize18,
            ),
          ),
        ],
      ),
      foregroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      actions: showEditButton??false
          ? [TextButton.icon(
          onPressed: () {
            if(onEdit != null){
              onEdit!();
            }
          },
          icon: Image.asset(
            Assets.editIcon, // update with your actual asset path
            height: getHeightRatio() * 15,
            width: getWidthRatio() * 15,
            color: AppColors.getPrimaryColorFromContext(context), // optional: tint if needed
          ),
          label: CustomText(
            text: 'Edit',
            fontWeight: FontWeight.w500,
            fontSize: sizes?.fontSize16,
            color: AppColors.getPrimaryColorFromContext(context),
          ),
        ),
      ]
          : [],
      shape: hideBottomBorder??false? Border():const Border(
        bottom: BorderSide(
          color: AppColors.greyBordersColor,
          width: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
