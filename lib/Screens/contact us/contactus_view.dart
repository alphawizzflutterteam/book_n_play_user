import 'package:booknplay/Screens/Privacy_Policy/privacy_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'contactUsController.dart';

class ContactUsscr extends StatefulWidget {
  const ContactUsscr({Key? key}) : super(key: key);

  @override
  State<ContactUsscr> createState() => _ContactUsscrState();
}

class _ContactUsscrState extends State<ContactUsscr> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ContactUs(),
      builder: (controller) => SafeArea(
        child: /*Scaffold(
          //appBar: AppBar(forceMaterialTransparency: true),
          backgroundColor: Colors.amber,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CustomAppBar(onPressedLeading: () {}),
                    Positioned(top: 80,  child: bodyWidget(context)),

                  ],
                ),

              ],
            ),
          ),
        )*/Material(child: bodyWidget(context, controller)),
      ),
    );
  }

  Widget bodyWidget(context, ContactUs controller) {
    return Stack(
        children: [

          CustomAppBar(
              onPressedLeading: () {
                Get.back();
              },
              title: 'Contact Us'),
          /*CustomAppBar(onPressedLeading: () {}),*/
          Positioned(top: 80,  child: screenStackContainer(context)),
          Padding(padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.11),   child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            decoration:   const BoxDecoration(
              color: AppColors.whit,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                // Top-left corner radius
                topRight: Radius.circular(30),
                // Bottom-right corner with no rounding
              ),
            ),
            child:
            SingleChildScrollView(
              child: Column(children: [

                controller.data == null || controller.data == "" ? Container(

                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(child: CircularProgressIndicator(color: AppColors.primary,))) :
                //HtmlWidget('Hello World!')
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Html(data: controller.data,),
                ),

                //Container(height: 400,width: 400,color: Colors.amber,)
              ],),
            ),

          ))

          ,



        ]);
  }
}
