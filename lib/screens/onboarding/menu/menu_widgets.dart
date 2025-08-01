import 'package:flutter/material.dart';

import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';

class MenuGroupWidget extends StatelessWidget {
  final MenuGroup menuGroup;

  const MenuGroupWidget({super.key, required this.menuGroup});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
          child: Row(
            children: [
              CustomText(
                text: '${menuGroup.title} (${menuGroup.dishes.length})',
                fontSize: sizes?.fontSize18,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              const Spacer(),
              const Icon(Icons.add, color: AppColors.restaurantPrimaryColor),
              SizedBox(width: getWidth() * 0.01),
              CustomText(
                text: 'Add Dish',
                fontSize: sizes?.fontSize14,
                fontWeight: FontWeight.w500,
                color: AppColors.restaurantPrimaryColor,
              ),
            ],
          ),
        ),
        // SizedBox(height: getHeight() * 0.02),
        ...menuGroup.dishes.map((dish) => DishItemWidget(dish: dish)),
        Divider(height: getHeight() * 0.03),
      ],
    );
  }
}



class DishItemWidget extends StatelessWidget {
  final Dish dish;

  const DishItemWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: getWidth() * 0.05),
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
          // const SizedBox(width: 8),
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
  const CategoryBottomSheet({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getHeight() * .13,
      width: getWidth(),
      margin: EdgeInsets.symmetric(
        horizontal: getWidth() * .02,
        vertical: getHeight() * .01,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: getWidth() * 0.25,
            height: getHeight() * 0.006,
            decoration: BoxDecoration(
              color: AppColors.greyBordersColor,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          SizedBox(height: getHeight() * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Add Category Title',
                fontSize: sizes?.fontSize14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
              SizedBox(height: getWidth() * 0.015),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Icon(Icons.close, color: AppColors.primarySlateColor,),
              )
              
            ],
          ),
          SizedBox(height: getHeight() * 0.03),
          CustomField(
            borderColor: AppColors.greyBordersColor,
            hint: al.address,
            label: al.address,
          ),
          SizedBox(height: getHeight() * .02),

        ],
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