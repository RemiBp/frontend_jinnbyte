import 'package:choice_app/res/res.dart';
import 'package:choice_app/screens/languageSelection/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../appAssets/app_assets.dart';
import '../../l18n.dart';
import '../../routes/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // context.pushReplacement(Routes.languageSelectionRoute);
      context.pushReplacement(Routes.authRoute);
      // context.pushReplacement(Routes.reClaimAccountRoute);

    });
  }

  @override
  Widget build(BuildContext context) {
    AppTranslations.init(context);
    return Scaffold(
      body: Center(
        child: Image.asset(Assets.splashImage, height: getHeight() * .3),
      ),
    );
  }
}
