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
import '../restaurant/profile/profile_provider.dart';
import 'auth_provider.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AuthProvider>(context, listen: false);
    provider.init(context);
  }


  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
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
              textEditingController: fullNameController,
              borderColor: AppColors.greyBordersColor,
              hint: al.fullName,
              label: al.fullNamePlaceholder,
            ),
            SizedBox(height: getHeight() * .015),

            // ---- USERNAME ----
            CustomField(
              textEditingController: userNameController,
              borderColor: AppColors.greyBordersColor,
              hint: al.userName,
              label: al.userNamePlaceholder,
            ),
            SizedBox(height: getHeight() * .015),

            // ---- EMAIL ----
            CustomField(
              textEditingController: emailController,
              borderColor: AppColors.greyBordersColor,
              hint: al.emailPlaceholder,
              label: al.emailLabel,
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
                  initialValue: provider.phoneNumber ?? PhoneNumber.parse('+33'),
                  countrySelectorNavigator:
                  const CountrySelectorNavigator.page(),
                  onChanged: (phoneNumber) => provider.setPhoneNumber(phoneNumber),
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
                  textEditingController: passwordController,
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
                    child: Consumer<AuthProvider>(
                      builder: (context, state, child) {
                        return Checkbox(
                          side: BorderSide(color: HexColor.fromHex("#B3B3B3")),
                          value: state.agreed,
                          onChanged: (value) {
                            state.toggleAgreement(value!);
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        );
                      },
                    ),                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        text: al.signupAgreement,
                        style: TextStyle(
                          fontSize: sizes?.fontSize14,
                          fontFamily: Assets.onsetRegular,
                        ),
                        children: [
                          TextSpan(
                            text: al.termsOfService,
                            style: TextStyle(color: AppColors.getPrimaryColorFromContext(context)),
                          ),
                          TextSpan(text: " ${al.andLabel} "),
                          TextSpan(
                            text: al.privacyPolicy,
                            style: TextStyle(color: AppColors.getPrimaryColorFromContext(context)),
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
              buttonText: al.signupTitle,
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

            // ---- ALREADY HAVE ACCOUNT ----
            Center(
              child: Text.rich(
                TextSpan(
                  text: al.alreadyHaveAccount,
                  style: TextStyle(
                    fontSize: sizes?.fontSize16,
                    fontFamily: Assets.onsetRegular,
                  ),
                  children: [
                    TextSpan(
                      text: al.loginButton,
                      style: TextStyle(
                        color: AppColors.getPrimaryColorFromContext(context),
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
