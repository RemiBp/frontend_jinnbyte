import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/network/network_provider.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/res/toasts.dart';
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
  // Form controllers
  late final TextEditingController addressController;
  late final TextEditingController passwordController;
  late final TextEditingController websiteController;
  late final TextEditingController instagramController;
  late final TextEditingController twitterController;
  late final TextEditingController facebookController;
  late final TextEditingController descriptionController;

  NetworkProvider networkProvider = NetworkProvider();

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    addressController = TextEditingController();
    passwordController = TextEditingController();
    websiteController = TextEditingController();
    instagramController = TextEditingController();
    twitterController = TextEditingController();
    facebookController = TextEditingController();
    descriptionController = TextEditingController();

    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.init(context);

    networkProvider = Provider.of<NetworkProvider>(context, listen: false);
    networkProvider.context = context;
  }

  @override
  void dispose() {
    // Dispose controllers
    addressController.dispose();
    passwordController.dispose();
    websiteController.dispose();
    instagramController.dispose();
    twitterController.dispose();
    facebookController.dispose();
    descriptionController.dispose();
    super.dispose();
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
                Expanded(
                  child: CustomText(
                    text: al.profileSetup,
                    fontSize: sizes?.fontSize28,
                    fontFamily: Assets.onsetSemiBold,
                  ),
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
              clipBehavior: Clip.none, // allow overflow
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
                            colorFilter: ColorFilter.mode(
                              Colors.grey.shade600,
                              BlendMode.srcIn,
                            ),
                          )
                          : null,
                ),
                Positioned(
                  right: -getWidth() * .017,  // push outward horizontally
                  bottom: -getHeight() * .017, // push outward vertically
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.getPrimaryColorFromContext(
                        context,
                      ),
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
                ),
              ],
            ),
            SizedBox(height: getHeight() * .03),
            CustomField(
              textEditingController: addressController,
              borderColor: AppColors.greyBordersColor,
              hint: al.address,
              label: al.address,
            ),
            SizedBox(height: getHeight() * .02),
            Row(
              children: [
                CustomText(
                  text: al.phoneNumber,
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                ),
                CustomText(
                  text: ' *',
                  fontSize: sizes!.fontSize14,
                  fontFamily: Assets.onsetMedium,
                  color: AppColors.redColor,
                ),

              ],
            ),
            SizedBox(height: getHeight() * .01),
            PhoneFormField(
              initialValue: provider.phoneNumber ?? PhoneNumber.parse('+33'),
              countrySelectorNavigator: const CountrySelectorNavigator.page(),
              onChanged: (phoneNumber) => provider.setPhoneNumber(phoneNumber),
              decoration: InputDecoration(
                border: buildOutlineInputBorder(AppColors.greyBordersColor),
                focusedBorder: buildOutlineInputBorder(
                  AppColors.inputHintColor,
                ),
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
              textEditingController: websiteController,
              borderColor: AppColors.greyBordersColor,
              hint: "yoursite.io",
              prefixIconSvg: Assets.websiteIcon,
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: instagramController,
              borderColor: AppColors.greyBordersColor,
              hint: "https://www.instagram.com/@yourhan...",
              prefixIconSvg: Assets.instagramIcon,
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: twitterController,
              borderColor: AppColors.greyBordersColor,
              hint: "https://www.twitter.com/@yourhandle...",
              prefixIconSvg: Assets.xIcon,
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: facebookController,
              borderColor: AppColors.greyBordersColor,
              hint: "https://www.facebook.com/@yourhan...",
              prefixIconSvg: Assets.facebookIcon,
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: descriptionController,
              height: getHeight() * .1,
              borderColor: AppColors.greyBordersColor,
              hint: al.writeSomethingBrief,
              label: al.briefDescription,
              maxLines: 3,
            ),
            SizedBox(height: getHeight() * .02),

            Row(
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
                  buttonText: 'Save Changes',
                  onTap: () async {
                    onTap: () async {
                      // context.push(Routes.editOperationHoursRoute);
                      // return;

                      if (provider.profilePhoto != null) {
                        final bytes = await provider.profilePhoto!.readAsBytes();
                        final fileUrl = await networkProvider.getUrlForFileUpload(
                          bytes,
                        );
                        if(fileUrl == null) {
                          Toasts.getErrorToast(text: "Failed to get image url");
                          return;
                        }
                        final success = await provider.updateProfile(
                          address: addressController.text,
                          password: passwordController.text,
                          website: websiteController.text,
                          instagram: instagramController.text,
                          twitter: twitterController.text,
                          facebook: facebookController.text,
                          description: descriptionController.text,
                          profileImageUrl: fileUrl,
                        );
                        // Only navigate to next screen if API call was successful
                        if (success && context.mounted) {
                          context.push(Routes.editOperationHoursRoute);
                        }
                      } else {
                        Toasts.getErrorToast(text: "Select profile image");
                      }
                  },
                  buttonWidth: getWidth() * .42,
                  backgroundColor: AppColors.getPrimaryColorFromContext(context),
                  borderColor: AppColors.getPrimaryColorFromContext(context),
                  textColor: AppColors.whiteColor,
                  textFontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
