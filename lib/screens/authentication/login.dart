import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/authentication/auth_provider.dart';
import 'package:choice_app/screens/authentication/auth_widgets.dart';
import 'package:choice_app/screens/authentication/passwordManagement/forgot_password.dart';
import 'package:choice_app/screens/authentication/signup.dart';
import 'package:choice_app/screens/restaurant/profile/profile.dart';
import 'package:choice_app/utilities/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../appAssets/app_assets.dart';
import '../../l18n.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
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
                  text: al.loginButton,
                  fontSize: sizes?.fontSize28,
                  fontFamily: Assets.onsetSemiBold,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.loginInstruction,
              fontSize: sizes?.fontSize16,
              color: AppColors.primarySlateColor,
              giveLinesAsText: true,
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
                  hidePassword: state.loginPassVisibility,
                  maxLines: 1,
                  clickIcon: () {
                    state.toggleLoginPassVisibility();
                  },
                );
              },
            ),
            SizedBox(height: getHeight() * .01),
            Row(
              children: [
                Checkbox(
                  side: BorderSide(color: HexColor.fromHex("#B3B3B3")),
                  value: true,
                  onChanged: (value) {},
                ),
                CustomText(
                  text: al.rememberMe,
                  fontSize: sizes?.fontSize16,
                  color: AppColors.primarySlateColor,
                  giveLinesAsText: true,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    context.push(Routes.forgotPasswordRoute);
                  },
                  child: CustomText(
                    text: "${al.forgotPassword}?",
                    fontSize: sizes?.fontSize16,
                    color: AppColors.primaryColor,
                    textDecoration: TextDecoration.underline,

                    giveLinesAsText: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomButton(
              buttonText: al.loginButton,
              onTap: () {
                context.push(Routes.restaurantProfileRoute);
                // context.push(Routes.customerHomeRoute);
                // context.push(Routes.customerHomeRoute);
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
                  text: "${al.noAccountPrompt} ",
                  style: TextStyle(
                    fontSize: sizes?.fontSize16,
                    fontFamily: Assets.onsetRegular,
                  ),
                  children: [
                    TextSpan(
                      text: al.signupTitle,
                      style: TextStyle(color: AppColors.primaryColor),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              context.pushReplacement(Routes.signupRoute);
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
