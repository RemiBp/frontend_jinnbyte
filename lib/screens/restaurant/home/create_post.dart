import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/screens/customer/home/choiceWidgets/share_experience.dart';
import 'package:flutter/material.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../res/res.dart';
import '../../../utilities/extensions.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
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

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: "Photos",
                      fontFamily: Assets.onsetMedium,
                      fontSize: sizes?.fontSize16,
                      ),
                    CustomText(
                      text: " *",
                      fontSize: sizes?.fontSize16,
                      color: Colors.red,
                    ),
                  ]
                ),
                CustomText(
                  text: "File supported: PNG, JPG",
                  fontSize: sizes?.fontSize12,
                ),
                SizedBox(height: getHeight() * .02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    // ~342 x 200 in responsive terms
                    width: getWidth() * 0.91,   // ~342px on standard widths
                    height: getHeight() * 0.25, // ~200px on standard heights
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.greyBordersColor),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: "Choose a file",
                            fontFamily: Assets.onsetMedium,
                            fontSize: sizes?.fontSize14,
                          ),
                          SizedBox(height: getHeight() * 0.005),
                          CustomText(
                            text: "Up to 5 images",
                            fontSize: sizes?.fontSize14,
                            color: HexColor.fromHex("#686A82"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: getHeight() * .02),
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: "e.g Sunday Brunch at The Maple House",
              label: "Title",
            ),
            SizedBox(height: getHeight() * .02),

            CustomField(
              height: getHeight() * .1,
              borderColor: AppColors.greyBordersColor,
              hint: "Describe your event...",
              label: "Description",
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: "e.g: #cozy, #outdoor_seating",
              label: "Tags",
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: "Add location",
              label: "Location",
              suffixIcon:Icons.location_on,
              obscure: true,
            ),
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
                      backgroundColor: Colors.transparent,
                      buttonWidth: getWidth() * 0.43,
                      height: getHeight() * 0.055,
                      buttonText: "Cancel",
                      textColor: AppColors.blackColor,
                      borderColor: AppColors.blackColor,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: getWidth() * 0.035),
                  Expanded(
                    child: CustomButton(
                      buttonWidth: getWidth() * 0.43,
                      height: getHeight() * 0.055,
                      borderColor: AppColors.getPrimaryColorFromContext(context),
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
}
