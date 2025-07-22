import 'package:choice_app/appColors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_text.dart';
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

  Widget buildRatingRow(String title, double rating) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontSize: sizes?.fontSize16),
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
                color: HexColor.fromHex("#FEF5E7"),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: HexColor.fromHex("#FDECCF"),
                    ),
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(Assets.knifeForkIcon),
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
                      dishRadio("Al Salmone", "\$20"),
                      dishRadio("Maki (3)", "\$20"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Dish Ratings
            Card(
              child: Column(
                children: [
                  ListTile(title: Text("Rate the Selected Dishes")),
                  buildDishRating("Al Salmone", 2.0),
                  buildDishRating("Maki Saumon", 4.0),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Photo Upload
            Card(
              child: Column(
                children: [
                  ListTile(title: Text("Photos")),
                  Container(
                    height: 100,
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Text(
                        "Choose a file\nUp to 5 images",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Tags
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Tags",
                    hintText: "@e.g. #cozy, #outdoor_seating",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Share Experience
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Share Your Experience",
                    hintText: "Share your experience...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Visibility
            Card(
              child: Column(
                children: [
                  ListTile(title: Text("Public")),
                  buildRadio("Public"),
                  buildRadio("Friends Only"),
                  buildRadio("Private"),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Publish"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dishRadio(String title, String price) {
    return RadioListTile(
      title: Text("$title - $price"),
      value: title,
      groupValue: selectedDish,
      onChanged: (value) {
        setState(() {
          selectedDish = value.toString();
        });
      },
    );
  }

  Widget buildDishRating(String dish, double rating) {
    return ListTile(
      title: Text(dish),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(rating.toStringAsFixed(1)),
        ],
      ),
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
