import 'package:choice_app/appColors/colors.dart';
import 'package:flutter/material.dart';
import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../res/res.dart';

class ProfileMenuAppBar extends StatelessWidget implements PreferredSizeWidget {

  final Function onSetting;

  const ProfileMenuAppBar({
    super.key,
    required this.onSetting,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: sizes!.pagePadding),
            child: CustomText(
              text: "The Wholesome Fork",
              fontWeight: FontWeight.w600,
              fontSize: sizes?.fontSize18,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(width: getWidth() * 0.02),
          Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.blackColor,)
        ],
      ),
      foregroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: ()=> onSetting(),
          child: Padding(
            padding: EdgeInsets.only(right: sizes!.pagePadding),
            child: Image.asset(Assets.settingIcon, height: getHeight() * 0.04,),
          ),
        )
      ],
      shape: const Border(
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

class RestaurantProfileHeader extends StatelessWidget {
  const RestaurantProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://i.imgur.com/QCNbOAo.png', // Replace with your image
            ),
          ),
          SizedBox(width: getWidth() * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "The Wholesome Fork",
                textOverflow: TextOverflow.ellipsis,
                fontSize: sizes?.fontSize16,
                color:AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text: "example@thewholesomefork.com",
                textOverflow: TextOverflow.ellipsis,
                fontSize: sizes?.fontSize14,
                color:AppColors.primarySlateColor,
                fontWeight: FontWeight.w400,
              ),

            ],
          )
        ],
      ),
    );
  }
}

class ProfileTabItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final int tabIndex;
  final int selectedTabIndex;

  const ProfileTabItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.tabIndex,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = tabIndex == selectedTabIndex;
    final Color activeColor = AppColors.getPrimaryColorFromContext(context);
    final Color textColor = isSelected ? activeColor : AppColors.inputHintColor;
    final Color iconColor = isSelected ? activeColor : Colors.grey;

    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: getWidth() * 0.04,
            color: iconColor,
          ),
          SizedBox(width: getWidth() * 0.01),
          CustomText(
            text: label,
            textOverflow: TextOverflow.ellipsis,
            fontSize: sizes?.fontSize14,
            color: textColor,
            fontWeight: FontWeight.w500,
            giveLinesAsText: true,
          ),
        ],
      ),
    );
  }
}



class OperatingHourItem extends StatelessWidget {
  const OperatingHourItem({super.key,
    required this.day,
    required this.time,
  });

  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getHeight() *  0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "$day:",
            fontSize: sizes?.fontSize14,
            fontWeight: FontWeight.w400,
            color: AppColors.primarySlateColor,
          ),
          CustomText(
            text: time,
            fontSize: sizes?.fontSize14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class CustomerProfileHeader extends StatelessWidget {
  const CustomerProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(Assets.choiceImage),
          ),
          SizedBox(width: getWidth() * 0.02),
          Expanded( // Ensures the right side takes remaining space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "The Wholesome Fork",
                  textOverflow: TextOverflow.ellipsis,
                  fontSize: sizes?.fontSize16,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem("98", "Choices"),
                    Image.asset(Assets.verticalLine, height: getHeight() * 0.03),
                    _buildStatItem("34", "Followers"),
                    Image.asset(Assets.verticalLine, height: getHeight() * 0.03),
                    _buildStatItem("02", "Followers"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        CustomText(
          text: value,
          textOverflow: TextOverflow.ellipsis,
          fontSize: sizes?.fontSize16,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
        ),
        CustomText(
          text: label,
          textOverflow: TextOverflow.ellipsis,
          fontSize: sizes?.fontSize12,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

class ProfileMenuDetailAppBar extends StatelessWidget implements PreferredSizeWidget {

  final Function onReport;
  final Function onBlock;

  const ProfileMenuDetailAppBar({
    super.key,
    required this.onReport,
    required this.onBlock,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: sizes!.pagePadding),
            child: Icon(Icons.arrow_back_ios, color: AppColors.blackColor,),
          ),
          Padding(
            padding: EdgeInsets.only(left: getWidth() * 0.02),
            child: CustomText(
              text: "The Wholesome Fork",
              fontWeight: FontWeight.w600,
              fontSize: sizes?.fontSize18,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(width: getWidth() * 0.02),
          Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.blackColor)
        ],
      ),
      foregroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      actions: [
        PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.more_vert, color: AppColors.blackColor,),
          color: AppColors.whiteColor,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Report',
              onTap: ()=> onReport(),
              child: Row(
                children: [
                  Icon(Icons.report, size: 18, color: AppColors.redColor,),
                  SizedBox(width: 8),
                  CustomText(
                    text: 'Report',
                    fontSize: sizes?.fontSize14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'Block',
              onTap: ()=> onBlock(),
              child: Row(
                children: [
                  Icon(Icons.block, size: 18, color: AppColors.redColor),
                  const SizedBox(width: 8),
                  CustomText(
                    text: 'Block',
                    fontSize: sizes?.fontSize14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.redColor,
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              // handle edit
            } else if (value == 'delete') {
              // handle delete
            }
          },
        )
      ],
      shape: const Border(
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


class BlockUserBottomSheet extends StatelessWidget {
  const BlockUserBottomSheet({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding,
          vertical: getHeight() * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap height to content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: getWidth() * 0.25,
                  height: getHeight() * 0.006,
                  decoration: BoxDecoration(
                    color: AppColors.greyBordersColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: getHeight() * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Block User',
                    fontSize: sizes?.fontSize18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: AppColors.primarySlateColor),
                  ),
                ],
              ),
              SizedBox(height: getHeight() * 0.03),
              CustomText(
                text: 'Blocking this user will prevent them from interacting with you. You can unblock them anytime from your Account Settings.',
                fontSize: sizes?.fontSize16,
                fontWeight: FontWeight.w400,
                color: AppColors.primarySlateColor,
                giveLinesAsText: true,
              ),
              SizedBox(height: getHeight() * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    buttonText: 'Cancel',
                    onTap: () => Navigator.pop(context),
                    buttonWidth: getWidth() * .42,
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.blackColor,
                    textColor: AppColors.blackColor,
                    textFontWeight: FontWeight.w700,
                  ),
                  CustomButton(
                    buttonText: 'Block',
                    onTap: () {},
                    buttonWidth: getWidth() * .42,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context),
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportBottomSheet extends StatelessWidget {
  const ReportBottomSheet({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding,
          vertical: getHeight() * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap height to content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: getWidth() * 0.25,
                  height: getHeight() * 0.006,
                  decoration: BoxDecoration(
                    color: AppColors.greyBordersColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: getHeight() * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Report User',
                    fontSize: sizes?.fontSize18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: AppColors.primarySlateColor),
                  ),
                ],
              ),
              SizedBox(height: getHeight() * 0.03),
              CustomText(
                text: 'Why do you want to report?',
                fontSize: sizes?.fontSize18,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
                giveLinesAsText: true,
              ),
              SizedBox(height: getHeight() * 0.01),
              CustomText(
                text: 'Blocking this user will prevent them from interacting with you. You can unblock them anytime from your Account Settings.',
                fontSize: sizes?.fontSize16,
                fontWeight: FontWeight.w400,
                color: AppColors.primarySlateColor,
                giveLinesAsText: true,
              ),
              SizedBox(height: getHeight() * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    buttonText: 'Cancel',
                    onTap: () => Navigator.pop(context),
                    buttonWidth: getWidth() * .42,
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.blackColor,
                    textColor: AppColors.blackColor,
                    textFontWeight: FontWeight.w700,
                  ),
                  CustomButton(
                    buttonText: 'Submit',
                    onTap: () {},
                    buttonWidth: getWidth() * .42,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context),
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}









