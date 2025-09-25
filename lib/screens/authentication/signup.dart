import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/authentication/auth_widgets.dart';
import 'package:choice_app/screens/restaurant/setting/setting_view.dart';
import 'package:choice_app/utilities/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../appAssets/app_assets.dart';
import '../../l18n.dart';
import '../onboarding/add_cuisine/add_cuisine.dart';
import 'auth_provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    AppTranslations.init(context);
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

            SizedBox(height: getHeight() * .01),
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: al.businessName,
              label: al.businessNamePlaceholder,
            ),
            SizedBox(height: getHeight() * .01),
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: al.emailPlaceholder,
              label: al.emailLabel,
            ),
            SizedBox(height: getHeight() * .01),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(0, -7),
                  child: Padding(
                    padding: EdgeInsets.only(right: getWidth() * 0.02), // small gap between box & text
                    child: Checkbox(
                      side: BorderSide(color: HexColor.fromHex("#B3B3B3")),
                      value: _agreed,
                      onChanged: (value) {
                        setState(() {
                          _agreed = value!;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // shrink default padding
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4), // tighter sizing
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        text: "${al.signupAgreement} ",
                        style: TextStyle(
                          fontSize: sizes?.fontSize14,
                          fontFamily: Assets.onsetRegular,
                        ),
                        children: [
                          TextSpan(
                            text: al.termsOfService,
                            style: TextStyle(color: AppColors.restaurantPrimaryColor),
                          ),
                          TextSpan(text: " ${al.andLabel} "),
                          TextSpan(
                            text: al.privacyPolicy,
                            style: TextStyle(color: AppColors.restaurantPrimaryColor),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: getHeight() * .025),
            CustomButton(
              buttonText: al.signupTitle,
              onTap: () {
                // Navigator.push(
                //   context,
                //   // MaterialPageRoute(builder: (context) => AddCuisine()),
                //   MaterialPageRoute(builder: (context) => SettingView()),
                // );
                context.push(Routes.otpVerificationRoute);
              },
            ),
            SizedBox(height: getHeight() * .02),
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.greyBordersColor)),
                CustomText(text: "  Or  ", fontSize: sizes?.fontSize14),
                Expanded(child: Divider(color: AppColors.greyBordersColor)),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SocialButton(
                  buttonLabel: al.signupWithApple,
                  svgString: Assets.appleIcon,
                  onPress: () {},
                ),
                SocialButton(
                  buttonLabel: al.signupWithGoogle,
                  svgString: Assets.googleIcon,
                  onPress: () {},
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "${al.alreadyHaveAccount} ",
                  style: TextStyle(
                    fontSize: sizes?.fontSize16,
                    fontFamily: Assets.onsetRegular,
                  ),
                  children: [
                    TextSpan(
                      text: al.loginButton,
                      style: TextStyle(color: AppColors.restaurantPrimaryColor),
                      recognizer: TapGestureRecognizer()..onTap=(){
                        context.pushReplacement(Routes.loginRoute);
                      }
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
