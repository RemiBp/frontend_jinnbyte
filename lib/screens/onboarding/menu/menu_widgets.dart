import 'package:flutter/material.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../res/res.dart';

class MenuGroupWidget extends StatelessWidget {
  final MenuGroup menuGroup;
  final Function onAddDish;
  final bool? showOption;
  final bool? hideBorder;
  final String? optionText;
  final String? header;

  const MenuGroupWidget({super.key, required this.menuGroup, required this.onAddDish, this.hideBorder, this.showOption, this.optionText, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: showOption??false?EdgeInsets.symmetric(horizontal: getWidth() * 0.05):EdgeInsets.zero,
          child: Row(
            children: [
              CustomText(
                text: header??'${menuGroup.title} (${menuGroup.dishes.length})',
                fontSize: sizes?.fontSize16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              const Spacer(),
              if(showOption??false)
              const Icon(Icons.add, color: AppColors.restaurantPrimaryColor),
              SizedBox(width: getWidth() * 0.01),
              GestureDetector(
                onTap: ()=> onAddDish(),
                child: CustomText(
                  text: optionText??'Add Dish',
                  fontSize: sizes?.fontSize14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.restaurantPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: getHeight() * 0.02),
        ...menuGroup.dishes.map((dish) => DishItemWidget(dish: dish, showOption: showOption,)),
        hideBorder??false?SizedBox():
        Divider(height: getHeight() * 0.03),
      ],
    );
  }
}


class MenuGroupWithoutOptionWidget extends StatelessWidget {
  final MenuGroup menuGroup;
  final Function onAddDish;
  final bool? showOption;
  final bool? hideBorder;
  final String? optionText;
  final String? header;

  const MenuGroupWithoutOptionWidget({super.key, required this.menuGroup, required this.onAddDish, this.hideBorder, this.showOption, this.optionText, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: header??'${menuGroup.title} (${menuGroup.dishes.length})',
          fontSize: sizes?.fontSize16,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
        // SizedBox(height: getHeight() * 0.02),
        ...menuGroup.dishes.map((dish) => DishItemWidget(dish: dish, showOption: showOption,)),
        Divider(height: getHeight() * 0.03),
      ],
    );
  }
}



class DishItemWidget extends StatelessWidget {
  final Dish dish;
  final bool? showOption;

  const DishItemWidget({super.key, required this.dish, this.showOption});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: showOption??false? EdgeInsets.only(left: getWidth() * 0.05):EdgeInsets.zero,
      title: CustomText(
        text: dish.name,
        fontSize: sizes?.fontSize14,
        fontWeight: FontWeight.w400,
        color: AppColors.blackColor,
      ),
      subtitle: CustomText(
        text: dish.description,
        fontSize: sizes?.fontSize12,
        fontWeight: FontWeight.w400,
        color: AppColors.primarySlateColor,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: '\$${dish.price}',
            fontSize: sizes?.fontSize14,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
          if(showOption??false)
          SizedBox(width: sizes!.pagePadding),
          if(showOption??false)
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.more_vert),
            color: AppColors.whiteColor,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit, size: 18),
                    SizedBox(width: 8),
                    CustomText(
                      text: 'Edit',
                      fontSize: sizes?.fontSize14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete, size: 18, color: Colors.red),
                    const SizedBox(width: 8),
                    CustomText(
                      text: 'Delete',
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
          ),
        ],
      ),
    );
  }
}

class CategoryBottomSheet extends StatelessWidget {
  const CategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
                      text: 'Add Category Title',
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
                CustomField(
                  borderColor: AppColors.greyBordersColor,
                  hint: "E.g: Eat Day, Main Menu, Specials...",
                  label: "Category Title",
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
                      buttonText: 'Save',
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
      ),
    );
  }
}

class AddDishBottomSheet extends StatelessWidget {
  const AddDishBottomSheet({super.key, required BuildContext context});

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
                    text: 'Add Dish',
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
              CustomField(
                borderColor: AppColors.greyBordersColor,
                hint: "E.g: Brochette boeuf...",
                label: "Dish Name",
              ),
              SizedBox(height: getHeight() * 0.02),
              CustomField(
                borderColor: AppColors.greyBordersColor,
                hint: "E.g: \$0.00",
                label: "Price",
              ),
              SizedBox(height: getHeight() * 0.02),
              CustomField(
                height: getHeight() * .1,
                borderColor: AppColors.greyBordersColor,
                hint: "Brief description of the dish...",
                label: "Description (Optional)",
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
                    buttonText: 'Save',
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



class MenuGroup {
  final String title;
  final List<Dish> dishes;

  MenuGroup({required this.title, required this.dishes});
}

class Dish {
  final String name;
  final String description;
  final double price;

  Dish({required this.name, required this.description, required this.price});
}