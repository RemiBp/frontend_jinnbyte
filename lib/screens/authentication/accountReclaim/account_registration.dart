import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/customWidgets/custom_textfield.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/utilities/extensions.dart';
import 'package:choice_app/l18n.dart';
import 'package:choice_app/res/toasts.dart';

import '../../../appAssets/app_assets.dart';
import '../../../userRole/role_provider.dart';
import '../auth_provider.dart';

class RegistrationScreen extends StatefulWidget {
  final int? claimProducerId;

  const RegistrationScreen({super.key, this.claimProducerId});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AuthProvider>(context, listen: false);
    provider.init(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppTranslations.init(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * 0.06,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Complete Your Registration",
              fontSize: sizes?.fontSize28,
              fontWeight: FontWeight.w600,
              fontFamily: Assets.onsetSemiBold,
              giveLinesAsText: true,
            ),
            CustomText(
                text: "Secure your account by adding your email and password",
                fontWeight: FontWeight.w400,
                fontSize: sizes?.fontSize16,
                fontFamily: Assets.onsetRegular,
                giveLinesAsText: true,
            ),
            SizedBox(height: getHeight() * 0.02),
            CustomField(
              textEditingController: emailController,
              borderColor: AppColors.greyBordersColor,
              hint: al.emailPlaceholder,
              label: al.emailLabel,
            ),
            SizedBox(height: getHeight() * 0.02),
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
            SizedBox(height: getHeight() * 0.04),
            CustomButton(
              buttonText: al.continueText,
              onTap: () {
                onContinueTap();
              },
              backgroundColor: AppColors.getPrimaryColorFromContext(context),
              borderColor: AppColors.getPrimaryColorFromContext(context),
            ),
          ],
        ),
      ),
    );
  }

  void onContinueTap() {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();


    if (email.isEmpty) {
      Toasts.getErrorToast(text: "Please enter your email");
    } else if (email.validateEmail() == false) {
      Toasts.getErrorToast(text: "Invalid email format");
    } else if (password.isEmpty) {
      Toasts.getErrorToast(text: "Please enter your password");
    } else {
      // Call your provider method here
      context.read<AuthProvider>().reclaimRegister(
        email: email,
        password: password,
        claimProducerId: widget.claimProducerId!,

      );
    }
  }
}
