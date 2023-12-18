import 'package:booknplay/Screens/Splash/splash_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.sizeOf(context).height;
    final widthSize = MediaQuery.sizeOf(context).width;
    return GetBuilder(
      init: SplashController(),
      builder: (controller) {
        return Container(
          height: heightSize,
          width: widthSize,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary,AppColors.secondary, ], // Define the colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,

              ),
          ),
          child: Image.asset('assets/images/splash_logo.png',scale: 2,),

        );
      },) ;
  }
}