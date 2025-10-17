import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../../../userRole/role_provider.dart';
import '../../../userRole/user_role.dart';

class ReclaimAccount extends StatefulWidget {
  const ReclaimAccount({super.key});

  @override
  State<ReclaimAccount> createState() => _ReclaimAccountState();
}

class _ReclaimAccountState extends State<ReclaimAccount> {
  int _selected = -1; // 0: Restaurant, 1: Leisure (preselected), 2: Wellness
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final roleProvider = context.read<RoleProvider>();
    switch (roleProvider.role) {
      case UserRole.restaurant:
        _selected = 0;
        break;
      case UserRole.leisure:
        _selected = 1;
        break;
      case UserRole.wellness:
        _selected = 2;
        break;
      default:
        _selected = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).size.width * 0.06;
    final roleProvider = context.read<RoleProvider>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(backgroundColor: AppColors.whiteColor),
      body:SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, 0, pad, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.reclaimAccount,
              fontSize: sizes?.fontSize26,
              fontFamily: Assets.onsetSemiBold,
            ),
            CustomText(
              text:al.retrieveAccess,
              fontSize: sizes?.fontSize16,
              color: AppColors.primarySlateColor,
            ),
            SizedBox(height: getHeight() * .01),
            CustomText(
              text:al.chooseOption,
              fontSize: sizes?.fontSize14,
              fontFamily: Assets.onsetMedium,
              color: AppColors.primarySlateColor,
            ),

            const SizedBox(height: 12),

            // Category chips
            Row(
              children: [
                CategoryChip(
                  label:al.categoryRestaurant,
                  svgString: Assets.restaurantIcon,
                  selected: _selected == 0,
                  onTap: () {
                    roleProvider.setRole(UserRole.restaurant);
                    setState(() => _selected = 0);
                  },
                  selectedColor: AppColors.restaurantPrimaryColor,
                ),
                const SizedBox(width: 12),
                CategoryChip(
                  label:al.categoryLeisure,
                  svgString: Assets.leisureIcon,
                  selected: _selected == 1,
                  onTap: () {
                    roleProvider.setRole(UserRole.leisure);
                    setState(() => _selected = 1);
                  },
                  selectedColor: AppColors.leisurePrimaryColor,
                ),
                const SizedBox(width: 12),
                CategoryChip(
                  label: al.categoryWellness,
                  svgString: Assets.wellnessIcon,
                  selected: _selected == 2,
                  onTap:() {
                    roleProvider.setRole(UserRole.wellness);
                    setState(() => _selected = 2);
                  },

                  selectedColor: AppColors.wellnessPrimaryColor,
                ),
              ],
            ),
            const SizedBox(height: 20),

            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: al.searchPlaceholder,
              prefixIconSvg: Assets.searchIcon,
            ),
            SizedBox(height: getHeight() * .03),

            CustomButton(
              buttonText: al.claimAccount,
              backgroundColor:
              _selected == 0
                  ? AppColors.restaurantPrimaryColor
                  : _selected == 1
                  ? AppColors.leisurePrimaryColor
                  : AppColors.wellnessPrimaryColor,
              onTap: () {
                context.push(Routes.uploadReclaimDocsRoute);
              },
            ),

            SizedBox(height: getHeight() * .02),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.greyBordersColor,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: CustomText(text: al.orText, fontSize: sizes?.fontSize14),
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.greyBordersColor,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomButton(
              buttonText:al.signupTitle,
              backgroundColor: AppColors.blackColor,
              onTap: () {
                context.push(Routes.signupRoute);
              },
            ),
            SizedBox(height: getHeight() * .02),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final String svgString;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.selectedColor,
    required this.svgString,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? selectedColor : AppColors.greyBordersColor,
                width: 2.0,
              ),
            ),
            padding: EdgeInsets.all(getHeight() * .02),
            child: SvgPicture.asset(svgString, height: getHeight() * .035),
          ),
          const SizedBox(height: 8),
          CustomText(
            text: label,
            fontSize: sizes?.fontSize12,
            fontFamily: Assets.onsetMedium,
            color: AppColors.primarySlateColor,
          ),
        ],
      ),
    );
  }
}
