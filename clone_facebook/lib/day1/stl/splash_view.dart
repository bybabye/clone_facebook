import 'package:clone_facebook/day1/stf/login_page.dart';

import 'package:clone_facebook/theme/app_assets.dart';
import 'package:flutter/material.dart';

import 'package:splash_screen_view/SplashScreenView.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const LoginPage(),
      duration: 3000,
      imageSize: 100,
      imageSrc: AppAssets.logo,
      text: "FaceBook",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
  }
}
