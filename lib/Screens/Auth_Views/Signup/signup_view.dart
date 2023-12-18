import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Auth_Views/Login/login_view.dart';
import 'package:booknplay/Screens/Auth_Views/Signup/signup_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/extentions.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = false;


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignupController(),
        builder: (controller) {
          return Scaffold(

            body: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        customAuthDegine(context, 'Sign Up'),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                              color:  Color(0xfff6f6f6),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                // Top-left corner radius
                                topRight: Radius.circular(
                                    30), // Top-right corner radius
                                // Bottom-right corner with no rounding
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 30),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      obscureText: obscureText,
                                      controller: nameController,
                                      style:const TextStyle(color: AppColors.subTxtClr,fontSize: 14),
                                      validator: (val) {
                                        if (val!.isEmpty) {

                                          return " Name field cannot be empty";

                                        }
                                      },

                                      decoration: CustomInputDecoration.myCustomInputDecoration(
                                        hintText: 'Name',
                                        prefixIcon:Icons.person,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    TextFormField(
                                      obscureText: obscureText,
                                      controller: emailController,
                                      style:const TextStyle(color: AppColors.subTxtClr,fontSize: 14),
                                      validator: (val) {
                                        if (val!.isEmpty) {

                                          return "    Email field cannot be empty";

                                        } else if (!val.contains("@")||!val.contains("gmail")||!val.contains(".com")) {
                                          return "    please enter valid Email";
                                        }
                                      },

                                      decoration: CustomInputDecoration.myCustomInputDecoration(
                                        hintText: 'Email',
                                        prefixIcon:Icons.email,
                                      ),
                                    ),


                                    const SizedBox(
                                      height: 15,
                                    ),


                                    TextFormField(
                                      controller: mobileController,
                                      style: TextStyle(color: AppColors.subTxtClr,fontSize: 14),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "    Enter Mobile Number";


                                        } else if (val.length > 10||val.length<10) {
                                          return "    Please enter must 10 digit";
                                        }
                                      },

                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      decoration: CustomInputDecoration.myCustomInputDecoration(

                                        hintText: "Mobile Number",
                                        prefixIcon: Icons.call,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    // textField(
                                    //     title: 'Password',
                                    //     prefixIcon: Icons.lock,
                                    //     controller: passwordController),
                                    TextFormField(

                                      obscureText: obscureText,
                                      controller: passwordController,
                                      style: TextStyle(color: AppColors.subTxtClr,fontSize: 14),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "    Password field cannot be empty";
                                        }
                                      },
                                      decoration: CustomInputDecoration.myCustomInputDecoration(
                                        hintText: 'Password',
                                        prefixIcon:Icons.lock,
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              obscureText = !obscureText;
                                            });
                                          },
                                          child: Icon(
                                            obscureText ? Icons.visibility : Icons.visibility_off,color: AppColors.bluecolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Obx(
                                      () => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: controller.isLoading.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : AppButton(
                                                  title: 'Sign Up',
                                                  onTap: () {

                                                    if(_formKey.currentState!.validate()) {
                                                      controller.registerUser(
                                                          email: emailController
                                                              .text,
                                                          mobile: mobileController
                                                              .text,
                                                          password:
                                                              passwordController
                                                                  .text,
                                                          name: nameController
                                                              .text);
                                                    }
                                                  },
                                                )),
                                    ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/10,
                                    ),
                                    // Row(
                                    //     mainAxisAlignment: MainAxisAlignment.center,
                                    //     children: [
                                    //       ClipRRect(
                                    //         borderRadius:
                                    //             BorderRadius.circular(10.0),
                                    //         child: Image.asset(
                                    //             'assets/images/facebook (4).png'),
                                    //       ),
                                    //       const SizedBox(
                                    //         width: 10,
                                    //       ),
                                    //       ClipRRect(
                                    //         borderRadius:
                                    //             BorderRadius.circular(10.0),
                                    //         child: Image.asset(
                                    //             'assets/images/google.png'),
                                    //       )
                                    //     ]),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text(
                                              'Log In',
                                              style: TextStyle(
                                                  color: AppColors.bluecolor,
                                                  fontSize: 16),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
