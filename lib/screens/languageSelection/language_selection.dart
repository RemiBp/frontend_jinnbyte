import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/l18n.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/screens/authentication/signup.dart';
import 'package:choice_app/screens/languageSelection/language_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../appAssets/app_assets.dart';
import '../../routes/routes.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String selectedLanguage = 'English';

  void selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LanguageSelectionProvider>(
      context,
      listen: false,
    );
    selectedLanguage = provider.selectedLocal == "en" ? "English" : "French";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageSelectionProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * .05,
          vertical: getHeight() * .1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: al.selectLanguage,
              fontSize: sizes?.fontSize28,
              fontFamily: Assets.onsetSemiBold,
            ),
            SizedBox(height: getHeight() * .01),
            CustomText(
              text: al.choosePreferredLanguage,
              fontSize: sizes?.fontSize16,
              giveLinesAsText: true,
            ),

            SizedBox(height: getHeight() * .03),

            languageOption(label: 'English', flagPath: Assets.ukFlagIcon),

            const SizedBox(height: 12),

            languageOption(label: 'French', flagPath: Assets.franceFlagIcon),

            const SizedBox(height: 32),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final locale = selectedLanguage == "English" ? "en" : "fr";
                  //
                  provider.changeLocale(locale);
                  context.go(Routes.signupRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: CustomText(
                  text: al.continueText,
                  fontSize: sizes?.fontSize16,
                  fontFamily: Assets.onsetSemiBold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget languageOption({required String label, required String flagPath}) {
    bool isSelected = selectedLanguage == label;

    return InkWell(
      onTap: () => selectLanguage(label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.lightBlue : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(flagPath, height: getHeight() * .02),
            const SizedBox(width: 12),
            CustomText(
              text: label,
              fontSize: sizes?.fontSize16,
              fontFamily: Assets.onsetMedium,
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check, color: Colors.lightBlue, size: 20),
          ],
        ),
      ),
    );
  }
}
