import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/screens/authentication/passwordManagement/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../l18n.dart';
import '../../../res/toasts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState
        .of(context)
        .extra as Map<String, dynamic>?;
    final email = extra?["email"] ?? "nil";
    final otp = extra?["otp"] ?? "nil";
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
                if (Navigator.of(context).canPop()) ...[
                  CustomBackButton(),
                  SizedBox(width: getWidth() * .02),
                ],
                CustomText(
                  text: al.resetPasswordTitle,
                  fontSize: sizes?.fontSize28,
                  fontFamily: Assets.onsetSemiBold,
                ),
              ],
            ),
            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.resetPasswordNote,
              fontSize: sizes?.fontSize16,
              color: AppColors.primarySlateColor,
              giveLinesAsText: true,
            ),
            SizedBox(height: getHeight() * .03),
            Consumer<PasswordProvider>(
              builder: (context, state, child) {
                return CustomField(
                  textEditingController: passwordController,
                  borderColor: AppColors.greyBordersColor,
                  hint: al.newPasswordLabel,
                  label: al.newPasswordLabel,
                  obscure: true,
                  hidePassword: state.newPassVisibility,
                  maxLines: 1,
                  clickIcon: () {
                    state.toggleNewPassVisibility();
                  },
                );
              },
            ),
            SizedBox(height: getHeight() * .02),
            Consumer<PasswordProvider>(
              builder: (context, state, child) {
                return CustomField(
                  textEditingController: confirmPasswordController,
                  borderColor: AppColors.greyBordersColor,
                  hint: al.confirmPasswordLabel,
                  label: al.confirmPasswordLabel,
                  obscure: true,
                  hidePassword: state.confirmPassVisibility,
                  maxLines: 1,
                  clickIcon: () {
                    state.toggleConfirmPassVisibility();
                  },
                );
              },
            ),

            SizedBox(height: getHeight() * .04),
            CustomButton(
              buttonText: al.verifyButton,
              onTap: () {
                var password = passwordController.text.toString().trim();
                var confirmPassword =
                confirmPasswordController.text.toString().trim();
                if (password.isEmpty) {
                  Toasts.getErrorToast(text: "Password is missing");
                } else if (confirmPassword.isEmpty) {
                  Toasts.getErrorToast(text: "Confirm Password is missing");
                }
                else if (password != confirmPassword) {
                  Toasts.getErrorToast(
                      text: "new and confirm password not matched");
                } else {
                  context.read<PasswordProvider>().resetPasswordApi(
                    email: email,
                    otp: otp,
                    password: password,
                  );
                }

              },
            ),
            SizedBox(height: getHeight() * .02),
          ],
        ),
      ),
    );
  }
}
