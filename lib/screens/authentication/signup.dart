import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/authentication/auth_widgets.dart';
import 'package:choice_app/screens/restaurant/profile/profile_provider.dart';
import 'package:choice_app/userRole/role_provider.dart';
import 'package:choice_app/utilities/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../appAssets/app_assets.dart';
import '../../l18n.dart';
import '../../res/toasts.dart';
import 'auth_provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController businessNameController = TextEditingController();
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
    businessNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
              children: [
                if (context.canPop()) ...[
                  CustomBackButton(),
                  SizedBox(width: getWidth() * .02),
                ],
                CustomText(
                  text: al.signupTitle,
                  fontSize: sizes?.fontSize28,
                  fontFamily: Assets.onsetSemiBold,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.signupSubtitle,
              fontSize: sizes?.fontSize16,
              color: AppColors.primarySlateColor,
              giveLinesAsText: true,
            ),
            SizedBox(height: getHeight() * .01),
            CustomField(
              textEditingController: businessNameController,
              borderColor: AppColors.greyBordersColor,
              hint: al.businessName,
              label: al.businessName,
            ),
            SizedBox(height: getHeight() * .01),
            CustomField(
              textEditingController: emailController,
              borderColor: AppColors.greyBordersColor,
              hint: al.emailPlaceholder,
              label: al.emailLabel,
            ),
            SizedBox(height: getHeight() * .01),
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
                            style: TextStyle(color: AppColors.getPrimaryColorFromContext(context)),
                          ),
                          TextSpan(text: " ${al.andLabel} "),
                          TextSpan(
                            text: al.privacyPolicy,
                            style: TextStyle(color: AppColors.getPrimaryColorFromContext(context)),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomButton(
              buttonText: al.signupTitle,
              onTap: onSignupTap,
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
                      style: TextStyle(color: AppColors.getPrimaryColorFromContext(context),),
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

  onSignupTap() {
    // context.push(Routes.restaurantProfileRoute);
    // return;

    var email = emailController.text.toString().trim();
    var password = passwordController.text.toString().trim();
    var businessName = businessNameController.text.toString().trim();

    final nameRegex = RegExp(r"^[a-zA-Z0-9\s\-,.&']+$");
    final passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$%^&*(),.?":{}|<>_\-]+$');

    if (businessName.isEmpty) {
      Toasts.getErrorToast(text: "Business Name is Missing");
    } else if (!nameRegex.hasMatch(businessName)) {
    Toasts.getErrorToast(text: "Business Name contains invalid characters (no emojis allowed)");
    } else if (email.isEmpty) {
    Toasts.getErrorToast(text: "Email is Missing");
    } else if (email.validateEmail() == false) {
    Toasts.getErrorToast(text: "Invalid Email");
    } else if (password.isEmpty) {
    Toasts.getErrorToast(text: "Password is missing");
    } else if (!passwordRegex.hasMatch(password)) {
    Toasts.getErrorToast(text: "Password contains invalid characters (no emojis allowed)");
    } else {
    context.read<AuthProvider>().registerUser(
    businessName: businessName,
    email: email,
    role: context.read<RoleProvider>().role.name,
    password: password,
    );
    }
  }
}
