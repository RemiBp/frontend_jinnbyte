import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/restaurant/profile/profile_provider.dart';
import 'package:choice_app/screens/restaurant/profile/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../l18n.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * .05,
          vertical: getHeight() * .1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (context.canPop()) ...[
                  CustomBackButton(),
                  SizedBox(width: getWidth() * .02),
                ],
                CustomText(
                  text: al.profileSetup,
                  fontSize: sizes?.fontSize28,
                  fontFamily: Assets.onsetSemiBold,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: "Lorem ipsum dolor sit amet consectetur.",
              fontSize: sizes?.fontSize16,
              color: AppColors.primarySlateColor,
              giveLinesAsText: true,
            ),
            SizedBox(height: getHeight() * .02),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: getHeight() * .07,
                  backgroundColor: AppColors.greyColor,
                  backgroundImage:
                      provider.profileImage != null
                          ? FileImage(provider.profileImage!)
                          : null,
                  child:
                      provider.profileImage == null
                          ? SvgPicture.asset(
                            Assets.userIcon,
                            height: getHeight() * .05,
                            color: Colors.grey.shade600,
                          )
                          : null,
                ),
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.restaurantPrimaryColor,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return bottomSheet(context);
                      },
                    );
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: getHeight() * .022,
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight() * .03),
            CustomField(
              textEditingController: provider.addressController,
              borderColor: AppColors.greyBordersColor,
              hint: al.address,
              label: al.address,
            ),
            SizedBox(height: getHeight() * .01),
            CustomField(
              textEditingController: provider.passwordController,
              borderColor: AppColors.greyBordersColor,
              hint: al.passwordLabel,
              label: al.passwordLabel,
              obscure: true,
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.phoneNumber,
              fontSize: sizes!.fontSize14,
              fontFamily: Assets.onsetMedium,
            ),
            SizedBox(height: getHeight() * .01),
            PhoneFormField(
              initialValue: provider.phoneNumber ?? PhoneNumber.parse('+33'),
              countrySelectorNavigator: const CountrySelectorNavigator.page(),
              onChanged: (phoneNumber) => provider.setPhoneNumber(phoneNumber),
              decoration: InputDecoration(
                border:buildOutlineInputBorder(AppColors.greyBordersColor),
                focusedBorder: buildOutlineInputBorder(AppColors.inputHintColor),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              enabled: true,
              isCountrySelectionEnabled: true,
              isCountryButtonPersistent: true,
              countryButtonStyle: const CountryButtonStyle(
                showDialCode: true,
                showIsoCode: true,
                showFlag: true,
                flagSize: 16,
              ),
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.links,
              fontSize: sizes!.fontSize14,
              fontFamily: Assets.onsetMedium,
            ),
            SizedBox(height: getHeight() * .01),
            CustomField(
              textEditingController: provider.websiteController,
              borderColor: AppColors.greyBordersColor,
              hint: "yoursite.io",
              prefixIconSvg: Assets.websiteIcon,
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: provider.instagramController,
              borderColor: AppColors.greyBordersColor,
              hint: "https://www.instagram.com/@yourhan...",
              prefixIconSvg: Assets.instagramIcon,
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: provider.twitterController,
              borderColor: AppColors.greyBordersColor,
              hint: "https://www.twitter.com/@yourhandle...",
              prefixIconSvg: Assets.xIcon,
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: provider.facebookController,
              borderColor: AppColors.greyBordersColor,
              hint: "https://www.facebook.com/@yourhan...",
              prefixIconSvg: Assets.facebookIcon,
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: provider.descriptionController,
              height: getHeight() * .1,
              borderColor: AppColors.greyBordersColor,
              hint: al.writeSomethingBrief,
              label: al.briefDescription,
              maxLines: 3,
            ),
            SizedBox(height: getHeight() * .02),
            CustomButton(
              buttonText: al.next,
              onTap: () async {
                final success = await provider.updateProfile();
                // Only navigate to next screen if API call was successful
                if (success && context.mounted) {
                  context.push(Routes.editOperationHoursRoute);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
