import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/authentication/auth_widgets.dart';
import 'package:choice_app/utilities/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../appAssets/app_assets.dart';
import '../../l18n.dart';
import 'auth_provider.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    AppTranslations.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * .05,
          vertical: getHeight() * .07,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (context.canPop()) ...[
                  CustomBackButton(),
                  SizedBox(width: getWidth() * .02),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: al.signupTitle,
                        fontSize: sizes?.fontSize28,
                        fontFamily: Assets.onsetSemiBold,
                      ),
                      SizedBox(height: getHeight() * .005),
                      CustomText(
                        text: al.signupSubtitle,
                        fontSize: sizes?.fontSize16,
                        color: AppColors.primarySlateColor,
                        giveLinesAsText: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: getHeight() * .02),

            // ---- FULL NAME ----
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: al.fullName,
              label: al.fullNamePlaceholder,
            ),
            SizedBox(height: getHeight() * .015),

            // ---- USERNAME ----
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: al.userName,
              label: al.userNamePlaceholder,
            ),
            SizedBox(height: getHeight() * .015),

            // ---- EMAIL ----
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: al.emailLabel,
              label: al.emailPlaceholder,
            ),
            SizedBox(height: getHeight() * .015),

            // ---- PHONE NUMBER ----
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  initialValue: PhoneNumber.parse('+33'),
                  countrySelectorNavigator:
                  const CountrySelectorNavigator.page(),
                  onChanged: (phoneNumber) =>
                      debugPrint('changed into $phoneNumber'),
                  decoration: InputDecoration(
                    border: buildOutlineInputBorder(AppColors.greyBordersColor),
                    focusedBorder:
                    buildOutlineInputBorder(AppColors.inputHintColor),
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
              ],
            ),

            SizedBox(height: getHeight() * .015),

            // ---- PASSWORD ----
            Consumer<AuthProvider>(
              builder: (context, state, child) {
                return CustomField(
                  borderColor: AppColors.greyBordersColor,
                  hint: al.passwordLabel,
                  label: al.passwordLabel,
                  obscure: true,
                  hidePassword: state.signupPassVisibility,
                  maxLines: 1,
                  clickIcon: () {
                    state.toggleSignupPassVisibility();
                  },
                );
              },
            ),

            SizedBox(height: getHeight() * .02),

            // ---- TERMS CHECKBOX ----
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(0, -7),
                  child: Padding(
                    padding: EdgeInsets.only(right: getWidth() * 0.02),
                    child: Checkbox(
                      side: BorderSide(color: HexColor.fromHex("#B3B3B3")),
                      value: _agreed,
                      onChanged: (value) {
                        setState(() {
                          _agreed = value!;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        text: "By signing up, you agree to our ",
                        style: TextStyle(
                          fontSize: sizes?.fontSize14,
                          fontFamily: Assets.onsetRegular,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: AppColors.restaurantPrimaryColor,
                            ),
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: AppColors.restaurantPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: getHeight() * .025),

            // ---- SIGNUP BUTTON ----
            CustomButton(
              buttonText: "Signup",
              onTap: () {
                context.push(Routes.otpVerificationRoute);
              },
            ),

            SizedBox(height: getHeight() * .02),

            // ---- DIVIDER ----
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.greyBordersColor)),
                CustomText(text: "  Or  ", fontSize: sizes?.fontSize14),
                Expanded(child: Divider(color: AppColors.greyBordersColor)),
              ],
            ),

            SizedBox(height: getHeight() * .02),

            // ---- SOCIAL BUTTONS ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SocialButton(
                  buttonLabel: "Apple",
                  svgString: Assets.appleIcon,
                  onPress: () {},
                ),
                SocialButton(
                  buttonLabel: "Google",
                  svgString: Assets.googleIcon,
                  onPress: () {},
                ),
              ],
            ),

            SizedBox(height: getHeight() * .02),

            // ---- ALREADY HAVE ACCOUNT ----
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    fontSize: sizes?.fontSize16,
                    fontFamily: Assets.onsetRegular,
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: AppColors.restaurantPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushReplacement(Routes.loginRoute);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
