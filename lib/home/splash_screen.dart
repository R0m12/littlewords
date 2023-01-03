import 'package:flutter/material.dart';
import 'package:littlewords/home/home_view.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const HomeView(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "assets/images/logo-no-background.png",
      text: "Splash Screen",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

  }
}