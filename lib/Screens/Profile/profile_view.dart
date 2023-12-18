import 'package:booknplay/Screens/Profile/profile_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/custom_clip_path.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
const ProfileScreen({Key? key, this.isFrom}) : super(key: key);
  final bool? isFrom;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        builder: (controller) => SafeArea(
              child: Scaffold(
                body: bodyWidget(context, controller),
              ),
            ));
  }

  Widget bodyWidget(BuildContext context, ProfileController controller) {
    return Obx(() => !controller.loading.value?SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: DiagonalPathClipperOne(),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.33,
                      color: Colors.red,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Image.asset(
                            'assets/images/splash_logo.png',
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  ClipPath(
                    clipper: DiagonalPathClipperOne(),
                    child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.33,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                AppColors.primary.withOpacity(0.5),
                                AppColors.secondary.withOpacity(0.5),
                                AppColors.secondary1.withOpacity(0.5)
                              ])),
                        )),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height / 7,
                    right: MediaQuery.sizeOf(context).width / 3,
                    left: MediaQuery.sizeOf(context).width / 3,
                    child:

                    controller.imageFile != null?
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 5, color: AppColors.whit),
                              image:
                                   DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(controller.imageFile!))


                          ),
                        ),

                        //
                        //   /*backgroundImage: _image != null
                        //                   ? FileImage(_image!)
                        //               as ImageProvider<Object>
                        //                   : AssetImage(
                        //                   'assets/images/Profile.png')
                        //               as ImageProvider<
                        //                   Object>,*/ // Explicit casting
                        // ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showOptions(context, controller);
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.secondary,
                                ),
                              ),
                            )),
                      ],
                    )
:
                    Stack(
                    children: [
                    Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                        border:
                        Border.all(width: 5, color: AppColors.whit),
                        image:
                            DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(controller
                                .imagefiledummy
                                .toString()))),
                  ),

      //
      //   /*backgroundImage: _image != null
      //                   ? FileImage(_image!)
      //               as ImageProvider<Object>
      //                   : AssetImage(
      //                   'assets/images/Profile.png')
      //               as ImageProvider<
      //                   Object>,*/ // Explicit casting
      // ),
      Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              showOptions(context, controller);
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.secondary,
              ),
            ),
          )),
      ],
    )



    ),
                ],
              ),
              Center(
                  child: Text(
                controller.name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
              controller.isEditProfile
                  ? const SizedBox.shrink()
                  : Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          const Icon(Icons.account_balance_wallet_sharp,
                              color: AppColors.secondary),
                          Text(
                            controller.usedata.wallet == 'null'
                                ? '0.0'
                                : controller.wallet ?? '0.0',
                            style: const TextStyle(
                                fontSize: 16, color: AppColors.secondary),
                          ),
                        ])),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: controller.isEditProfile
                    ? Form(
                  key: controller.formKey,
                      child: Column(
                          children: [

                            // textFieldContainer(Icons.phone, 'Phone Number',
                            //
                            //     controller, controller.phoneC),


                            Column(

                              children: [
                                Row(
                                    children: [
                                      Icon(Icons.phone, color: AppColors.secondary,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Phone Number", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                                    ]
                                ),

                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 3,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    controller: controller.phoneC,
                                    decoration:  InputDecoration(
                                        hintText:  'Phone Number',
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.only(top: 0,left: 10),
                                        counterText: ""
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Phone Number';
                                      }
                                      else if (value.length<10) {
                                        return 'Please enter valid Phone Number';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),

                              ],
                            ),


                            const SizedBox(
                              height: 10,
                            ),
                            //
                            // textFieldContainer(Icons.email, 'Email Address',
                            //     controller, controller.emailC),

                            Column(
                              children: [
                                Row(children: [
                                  Icon(Icons.email, color: AppColors.secondary,),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Email Address', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                                ]),

                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 3,
                                  child: TextFormField(
                                    maxLength: 10,
                                    controller: controller.emailC,
                                    // obscureText: isSecure ?? false,
                                    decoration:  InputDecoration(
                                        hintText:  'Email Address',
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.only(top: 0,left: 10),
                                        counterText: ""
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Email';
                                      }
                                      else if (!value.contains('@')||!value.contains("gmail.com")) {
                                        return 'Please enter valid Email';
                                      }
                                      // else if (value.length<10) {
                                      //   return 'Please enter valid Phone Number';
                                      // }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),

                              ],
                            ),



                            const SizedBox(
                              height: 10,
                            ),
                            textFieldContainer(Icons.location_on, 'Address',
                                controller, controller.addressC),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.secondary,
                                      ),
                                    )
                                  : AppButton(
                                      title: 'Update profile',
                                      onTap: () {
                                        // controller.isEditProfile = false;


                                         controller.updateProfile();




                                      }),
                            )
                          ],
                        ),
                    )
                    : Column(
                        children: [
                          textContainer(Icons.email, 'Email Address',
                              controller.emailC.text),
                          const SizedBox(
                            height: 20,
                          ),
                          textContainer(Icons.phone, 'Phone Number',
                              '+91${controller.phoneC.text}'),
                          const SizedBox(
                            height: 20,
                          ),
                          textContainer(Icons.location_on, 'Address',
                              controller.addressC.text),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: controller.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.secondary,
                                    ),
                                  )
                                : AppButton(
                                    title: 'Edit profile',
                                    onTap: () {
                                      controller.isEditProfile = true;
                                      controller.update();
                                    }),
                          )
                        ],
                      ),
              )
            ],
          ),
        ):SizedBox(
      height: Get.height,
      width: Get.width,
      child:const Center(child: CircularProgressIndicator(),),
    ),);
  }

  Widget textContainer(IconData icon, String title, String data) {
    return Container(
      height: 90,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.whit,
          border: Border.all(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 0), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            )
          ]),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.secondary,
            size: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(data,
                  style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget textFieldContainer(
      IconData icon,
      String title,
      ProfileController controller,
      TextEditingController textEditingController) {
    return Column(
      children: [
        textviewRow(title, icon),
        otherTextField(controller: textEditingController),
      ],
    );
  }

  Widget textviewRow(String title, IconData icon) {
    return Row(children: [
      Icon(
        icon,
        color: AppColors.secondary,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      )
    ]);
  }

  Future showOptions(BuildContext context, ProfileController controller) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              controller.getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              controller.getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
}
