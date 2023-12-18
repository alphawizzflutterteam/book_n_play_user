
import 'package:booknplay/Constants.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  const ConfirmPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return Future.value();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding:const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                Image.asset(AppConstants.pay),
                 SizedBox(height: MediaQuery.of(context).size.height/20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Payment Successful",
                      style: Get.theme.textTheme.headlineMedium!.copyWith(
                        color: const Color(0xff333333),
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10,),
                Text(
                  "Lorem ipsum dolor sit amet consectetuer elit, sed\ndiam Lorem ipsum dolor sit amet,\nconsectetuer elit, sed diam",
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.labelLarge!.copyWith(
                      color: const Color(0xff7b7a7a),
                    fontSize: 12

                  ),
                ),
                const SizedBox(height: 50,),
                AppButton(title: 'Go To Home', onTap: (){
                  Get.offAllNamed(bottomBar);


                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
