import 'package:choice_app/appAssets/app_assets.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/res/res.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../customWidgets/common_app_bar.dart';
import '../../../l18n.dart';
import '../../authentication/passwordManagement/password_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: al.passwordManager),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * 0.05,
          vertical: getHeight() * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<PasswordProvider>(
              builder: (context, state, _) {
                return CustomField(
                  textEditingController: currentPasswordController,
                  borderColor: AppColors.greyBordersColor,
                  hint: al.currentPassword,
                  label: al.currentPassword,
                  obscure: true,
                  hidePassword: state.currentPassVisibility,
                  maxLines: 1,
                  clickIcon: () {
                    state.toggleCurrentPassVisibility();
                  },
                );
              },
            ),
            SizedBox(height: getHeight() * 0.02),
            Consumer<PasswordProvider>(
              builder: (context, state, _) {
                return CustomField(
                  textEditingController: newPasswordController,
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
            SizedBox(height: getHeight() * 0.02),
            Consumer<PasswordProvider>(
              builder: (context, state, _) {
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
          ],
        ),
      ),

      /// 👇 Stick the buttons at bottom
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(getWidth() * 0.05),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                buttonText: al.cancel,
                onTap: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.transparent,
                textColor: AppColors.blackColor,
                borderColor: AppColors.blackColor,
              ),
            ),
            SizedBox(width: getWidth() * 0.04),
            Expanded(
              child: CustomButton(
                buttonText: al.saveChanges,
                onTap: () {
                  // Only handle UI, no API call here
                },
                backgroundColor: AppColors.getPrimaryColorFromContext(context),
                textColor: Colors.white,
                borderColor: AppColors.getPrimaryColorFromContext(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

