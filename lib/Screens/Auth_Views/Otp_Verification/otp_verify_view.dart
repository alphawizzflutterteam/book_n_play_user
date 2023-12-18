import 'package:booknplay/Constants.dart';
import 'package:booknplay/Screens/Auth_Views/Otp_Verification/otp_verify_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _Otp();
}

class _Otp extends State<OTPVerificationScreen> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: OTPVerifyController(),
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    customAuthDegine(context, 'Verification',image: AppConstants.verifyOTP),
                    Padding(
                      padding:  EdgeInsets.only(top:255),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,

                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),   // Top-left corner radius
                            topRight: Radius.circular(30),  // Top-right corner radius
                            // Bottom-right corner with no rounding
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20,left: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 30,),
                              textView('Code has been sent to'),
                               Text("+91 ${controller.data[0].toString()}",style: const TextStyle(fontSize: 20),),
                               Text('OTP: ${controller.otp}',style: const TextStyle(fontSize: 20),),

                              const SizedBox(height: 30,),
                              PinCodeTextField(
                                //errorBorderColor:Color(0xFF5ACBEF),
                                //defaultBorderColor: Color(0xFF5ACBEF),
                                keyboardType: TextInputType.phone,

                                onChanged: (value) {
                                  controller.textotp = value.toString() ;
                                },

                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(15),
                                  activeColor: AppColors.activeBorder,
                                  inactiveColor: AppColors.activeBorder,

                                  fieldHeight: 75,
                                  fieldWidth: 75,
                                  activeFillColor: Colors.white,
                                ),
                                //pinBoxRadius:20,
                                appContext: context, length: 4 ,
                              ),
                              const SizedBox(height: 30,),
                              textView("Haven't received the verification code?"),
                              SizedBox(height: 5,),
                              InkWell(
                                  onTap: () {

                                    controller.sendOtp(mobile: controller.data[0].toString());

                                  },
                                  child: const Text('Resend',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                              const SizedBox(height: 100,),
                              Obx(() => Padding(padding: const EdgeInsets.only(left: 25, right: 25), child: controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) :
                              AppButton(onTap: (){
                                if(controller.textotp=="${controller.otp}") {
                                  controller.verifyOTP();
                                }
                                else{

                                  Fluttertoast.showToast(msg: "Please Fill Correct OTP");
                                }
                                  },title: 'Verify'))

                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),


              ],
            ),
          ),
        );
      }
    );
  }



}