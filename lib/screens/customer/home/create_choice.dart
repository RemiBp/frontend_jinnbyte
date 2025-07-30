import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/screens/customer/home/choiceWidgets/share_experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
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

  Widget buildRatingRow(String title, double rating, {
    String?review,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(review != null)...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: title, fontSize: sizes?.fontSize16),
              InkWell(onTap: () {},
                child: CustomText(
                  text: "Remove",
                  fontSize: sizes?.fontSize14,
                  fontFamily: Assets.onsetMedium,
                  color: Colors.red,
                  decorationColor: Colors.red,
                  textDecoration: TextDecoration.underline,
                ),),
            ],
          ),
          CustomText(text: review, fontSize: sizes?.fontSize12),
        ] else
          ...[
            CustomText(text: title, fontSize: sizes?.fontSize16),
          ],

        SizedBox(height: getHeight() * .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  size: getHeight() * .03,
                  color: index < rating ? Colors.amber : AppColors.greyColor,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.yellow),
              ),
            ),
          ],
        ),
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
              text: "Your Experience",
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
                    text: "Overall Restaurant Rating",
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow("Service", 2.0),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow("Price", 0.0),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow("Portions", 4.0),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow("Ambiance", 4.0),
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
                  ListTile(
                    title: CustomText(
                      text: "Dishes and Menus Consumed",
                      fontFamily: Assets.onsetMedium,
                      fontSize: sizes?.fontSize16,
                    ),
                  ),
                  Column(
                    children: [
                      dishRadio(
                          menuName: "Brochettes (3)",
                          dishDetails: "Sauce blanche, saumon fume 2jdfj 232 1231 ",
                          "Al Salmone", "\$20"),
                      dishRadio(menuName: "Maki (3)",
                          dishDetails: "Sauce blanche, saumon fume",
                          "Maki (3)",
                          "\$20"),
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
                    text: "Overall Restaurant Rating",
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow(
                      "Al Salmone", 2.0, review: "Your rating for this dish:"),
                  SizedBox(height: getHeight() * .01),
                  buildRatingRow(
                      "Maki Saumon", 4.0, review: "Your rating for this dish:"),
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
                    text: "File supported: PNG, JPG",
                    fontSize: sizes?.fontSize12,
                  ),
                  Container(
                    height: getHeight() * .2,
                    width: double.infinity,
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
                              text: "Choose a file",
                              fontFamily: Assets.onsetMedium,
                              fontSize: sizes?.fontSize14,
                            ),
                            CustomText(
                              text: "Up to 5 images",
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
                label: "Tags",
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
                      height: getHeight() * .055,
                      backgroundColor: Colors.transparent,
                      buttonText: "Cancel",
                      textColor: Colors.black,
                      borderColor: Colors.black,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      height: getHeight() * .055,
                      buttonText: "Publish",
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: menuName,
          fontSize: sizes?.fontSize16,
          fontFamily: Assets.onsetSemiBold,
        ),
        ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: sizes?.fontSize16,
                    ),
                    CustomText(
                      text: price,
                      fontSize: sizes?.fontSize16,
                    ),

                  ],
                ),
                value: title,
                subtitle: SizedBox(
                  width: getWidth() * .6,
                  child: CustomText(
                    text: dishDetails,
                    fontSize: sizes?.fontSize12,
                  ),
                ),
                groupValue: selectedDish,
                onChanged: (value) {
                  setState(() {
                    selectedDish = value.toString();
                  });
                },
              );
            })
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
