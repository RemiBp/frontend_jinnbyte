import 'package:choice_app/res/res.dart';
import 'package:flutter/material.dart';

import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import 'menu_widgets.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final List<MenuGroup> menuGroups = [
    MenuGroup(
      title: 'Brochettes',
      dishes: List.generate(3, (_) => Dish(name: 'Al Salmone', description: 'Sauce blanche, saumon fume', price: 20)),
    ),
    MenuGroup(
      title: 'Maki',
      dishes: List.generate(3, (_) => Dish(name: 'Maki Saumon', description: 'Sauce blanche, saumon fume', price: 20)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Menu"),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: getHeight() * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
              child: CustomText(
                text: "Set Up Your Menu",
                fontSize: sizes?.fontSize28,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: getHeight() * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: menuGroups.length,
                itemBuilder: (context, index) {
                  return MenuGroupWidget(menuGroup: menuGroups[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05,vertical: getHeight() * 0.02),
              child: CustomButton(
                buttonText: '+ Add Category Title',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CategoryBottomSheet(context: context,);
                    },
                  );
                },
                backgroundColor: Colors.transparent,
                borderColor: AppColors.getPrimaryColorFromContext(context),
                textColor: AppColors.getPrimaryColorFromContext(context),
                textFontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    buttonText: 'Cancel',
                    onTap: () {
                      Navigator.pop(context);
                    },
                    buttonWidth: getWidth() * .42,
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.blackColor,
                    textColor: AppColors.blackColor,
                    textFontWeight: FontWeight.w700,
                  ),
                  CustomButton(
                    buttonText: 'Continue',
                    onTap: () {},
                    buttonWidth: getWidth() * .42,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context),
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
