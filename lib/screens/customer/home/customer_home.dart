import 'package:choice_app/appAssets/app_assets.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/customer/home/home_widgets.dart';
import 'package:choice_app/screens/restaurant/home/choice_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_textfield.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ChoiceProvider>(context, listen: false);
    provider.init(context);

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * .05,
          vertical: getHeight() * .07,
        ),
        child: Column(
          children: [
            Row(
              children: [
                CustomText(
                  text: "Choice",
                  fontSize: sizes?.fontSize28,
                  fontFamily: Assets.onsetSemiBold,
                ),
                Spacer(),
                CustomIconButton(svgString: Assets.mapIcon),
                SizedBox(width: getWidth() * .02),
                CustomIconButton(svgString: Assets.chatIcon),
                SizedBox(width: getWidth() * .02),
                CustomIconButton(svgString: Assets.notificationIcon),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: "Search by username or name...",
              prefixIconSvg: Assets.searchIcon,
            ),
            SizedBox(height: getHeight() * .02),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                    top: getHeight()*.01
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return PostCard();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
          ),
          backgroundColor: AppColors.userPrimaryColor,
          onPressed: (){
            // context.push(Routes.choiceSelectionRoute);
            context.push(Routes.restaurantCreatePostRoute);
          }, label: Row(
        children: [
          Icon(Icons.add, color: Colors.white,),
          CustomText(
            text: "Create",
            fontSize: sizes?.fontSize12,
            fontFamily: Assets.onsetMedium,
            color: Colors.white,
          ),
        ],
      )),
    );
  }
}

