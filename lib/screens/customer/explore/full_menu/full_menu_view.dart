import 'package:flutter/material.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/common_app_bar.dart';
import '../../../../l18n.dart';
import '../../../../res/res.dart';
import '../../../onboarding/menu/menu_widgets.dart';

class FullMenuView extends StatefulWidget {
  const FullMenuView({super.key});

  @override
  State<FullMenuView> createState() => _FullMenuViewState();
}

class _FullMenuViewState extends State<FullMenuView> {

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
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: al.menu),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: getHeight() * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: menuGroups.length,
                padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
                itemBuilder: (context, index) {
                  return MenuGroupWithoutOptionWidget(
                    menuGroup: menuGroups[index],
                    showOption: false,
                    hideBorder: true,header: "Salads",
                    onAddDish: (){},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
