import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/screens/customer/home/choiceWidgets/share_experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../../../utilities/extensions.dart';

class CreateChoice extends StatefulWidget {
  const CreateChoice({super.key});

  @override
  _CreateChoiceState createState() => _CreateChoiceState();
}

class _CreateChoiceState extends State<CreateChoice> {
  String selectedDish = '';
  String visibility = 'Public';

  Widget buildRatingRow(
      String title,
      double rating, {
        String? review,
        bool isLast = false, //  new flag to control divider
      }) {
    final bool isZero = rating == 0;
    final Color activeColor = isZero ? AppColors.inputHintColor : Colors.orange;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + optional Remove
        if (review != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                fontSize: sizes?.fontSize16,
                fontFamily: Assets.onsetMedium,
              ),
              InkWell(
                onTap: () {},
                child: CustomText(
                  text: al.remove,
                  fontSize: sizes?.fontSize14,
                  fontFamily: Assets.onsetMedium,
                  color: Colors.red,
                  decorationColor: Colors.red,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          SizedBox(height: getHeight() * .005),
          CustomText(
            text: review,
            fontSize: sizes?.fontSize12,
          ),
        ] else ...[
          CustomText(
            text: title,
            fontSize: sizes?.fontSize16,
            fontFamily: Assets.onsetMedium,
          ),
        ],

        SizedBox(height: getHeight() * .01),

        // Stars + Rating Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(
                5,
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.star,
                    size: 28, // exactly 28px
                    color: index < rating ? Colors.amber : AppColors.greyColor,
                  ),
                ),
              ),
            ),
            Container(
              width: getWidth() * 0.12,
              height: getHeight() * 0.045,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: activeColor, width: 1.5), //  fixed border
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomText(
                text: rating.toStringAsFixed(1),
                fontSize: sizes?.fontSize14,
                fontFamily: Assets.onsetMedium,
                color: activeColor, //  same as border
              ),
            ),
          ],
        ),

        if (!isLast) ...[
          SizedBox(height: getHeight() * .015),
          Divider(height: 1, color: AppColors.greyBordersColor),
          SizedBox(height: getHeight() * .015),
        ],
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final data = GoRouterState
        .of(context)
        .extra as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Choice'),
        leading: BackButton(),
        elevation: 0,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * .05,
          vertical: getHeight() * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: data?["title"] == "Leisure"
                    ? HexColor.fromHex("#F4E9F6")
                    : data?["title"] == "Wellness"
                    ? HexColor.fromHex("#EDF7EE")
                    : HexColor.fromHex("#FEF5E7"),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: data?["title"] == "Leisure" ? HexColor.fromHex(
                          "#E9D5EC") : data?["title"] == "Wellness" ? HexColor
                          .fromHex("#DCEEDC") : HexColor.fromHex("#FDECCF"),
                    ),
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(data?["icon"]),
                  ),
                  SizedBox(width: getWidth() * .03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Olivia",
                        fontSize: sizes?.fontSize14,
                        fontFamily: Assets.onsetMedium,
                        giveLinesAsText: true,
                      ),
                      SizedBox(height: getHeight() * .005),
                      CustomText(
                        text: "58 Rue de Tilloy, Beauvais, Oise, France",
                        fontSize: sizes?.fontSize12,
                        giveLinesAsText: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.yourExperience,
              fontFamily: Assets.onsetSemiBold,
              fontSize: sizes?.fontSize18,
            ),

            SizedBox(height: 16),

            // Ratings Section
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: al.overallRestaurantRating,
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow(al.service, 2.0),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow(al.price, 0.0),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow(al.portions, 4.0),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow(al.ambiance, 4.0, isLast: true),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Dishes Section
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomText(
                    text: al.dishesAndMenusConsumed,
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  SizedBox(height: getHeight() * .01),

                  Column(
                    children: [
                      dishRadio(
                          menuName: "Brochettes (3)",
                          dishDetails: "Sauce blanche, saumon fume ",
                          "Al Salmone", "\$20"),
                      dishRadio(menuName: "Maki (3)",
                          dishDetails: "Sauce blanche, saumon fume",
                          "Maki (3)",
                          "\$20", isLast: true),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Dish Ratings
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: al.rateTheSelectedDishes,
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow(
                      "Al Salmone", 2.0, review: al.yourRatingForThisDish),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow(
                      "Maki Saumon", 4.0, review: al.yourRatingForThisDish, isLast: true),
                ],
              ),
            ),

            SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Photos",
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  CustomText(
                    text: al.fileSupport,
                    fontSize: sizes?.fontSize12,
                  ),
                  Container(
                    height: getHeight() * 0.237,  // ~200px
                    width: getWidth() * 0.77,     // ~302px
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.greyBordersColor,
                        )
                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: al.chooseAFile,
                              fontFamily: Assets.onsetMedium,
                              fontSize: sizes?.fontSize14,
                            ),
                            CustomText(
                              text: al.upTo5Images,
                              fontSize: sizes?.fontSize14,
                              color: HexColor.fromHex("#686A82"),
                            ),

                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: getHeight() * .02),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: CustomField(
                borderColor: AppColors.greyBordersColor,
                hint: "e.g: #cozy, #outdoor_seating",
                label: al.tags,
              ),
            ),
            SizedBox(height: getHeight() * .02),
            ShareExperienceWidget(),
            SizedBox(height: getHeight() * .02),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getHeight() * .02,
                horizontal: getWidth() * .05,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonWidth: getWidth() * 0.43,
                      height: getHeight() * 0.055,
                      buttonText: al.cancel,
                      backgroundColor: Colors.transparent,
                      textColor: AppColors.blackColor,
                      borderColor: AppColors.blackColor,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      buttonWidth: getWidth() * 0.43,
                      height: getHeight() * 0.055,
                      borderColor: AppColors.getPrimaryColorFromContext(context),                      backgroundColor: AppColors.userPrimaryColor,
                      buttonText: al.next,
                      textColor: AppColors.whiteColor,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dishRadio(String title, String price, {
    required String menuName,
    required String dishDetails,
    bool isLast = false, // new flag for divider
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // menu title (e.g. "Brochettes (3)")
        Padding(
          padding: EdgeInsets.only(bottom: getHeight() * 0.008),
          child: CustomText(
            text: menuName,
            fontSize: sizes?.fontSize16,
            fontFamily: Assets.onsetSemiBold,
          ),
        ),

        // keep ListView.builder as you requested
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3, // keep your item count
          itemBuilder: (context, index) {
            // create a unique value for each radio (prevents collisions across groups)
            final itemValue = '$menuName|$title|$index';
            final bool isSelected = selectedDish == itemValue;

            return InkWell(
              onTap: () {
                setState(() {
                  selectedDish = itemValue;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: getHeight() * 0.012),
                // ensure consistent visual alignment between items
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // <-- key: center aligns price+radio
                  children: [
                    // left side: title + subtitle (expands)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: title,
                            fontSize: sizes?.fontSize14,
                          ),
                          SizedBox(height: getHeight() * 0.006),
                          CustomText(
                            text: dishDetails,
                            fontSize: sizes?.fontSize12,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: getWidth() * 0.03),

                    // right side: price and radio grouped together so they align vertically
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: price,
                          fontSize: sizes?.fontSize14,
                        ),
                        SizedBox(width: getWidth() * 0.02),
                        //  custom radio
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : AppColors.greyColor,
                              width: 2,
                            ),
                            color: isSelected ? Colors.blue : Colors.transparent,
                          ),
                          child: isSelected
                              ? Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (!isLast) ...[
          SizedBox(height: getHeight() * 0.01),
          Divider(color: AppColors.greyBordersColor, thickness: 1),
          SizedBox(height: getHeight() * 0.01),
        ],
      ],
    );
  }


  Widget buildRadio(String label) {
    return RadioListTile(
      title: Text(label),
      value: label,
      groupValue: visibility,
      onChanged: (value) {
        setState(() {
          visibility = value.toString();
        });
      },
    );
  }
}

