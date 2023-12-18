import 'package:booknplay/Screens/FAQ/faq_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'notification_controller.dart';


class Notification_Screen extends StatelessWidget {
  Notification_Screen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Notification_Controller(),
      builder: (controller) => SafeArea(
          child: Material(
            child: bodyWidget(context, controller),
          )),
    );
  }

  List<Widget> _buildExpansionTileChildren(FAQController controller, int index) => [
    Container(
      padding: const EdgeInsets.all(20),
      child:  Text(controller.faqDataList[index].description ?? '',
        textAlign: TextAlign.justify,
      ),
    ),
  ];

  Widget bodyWidget(BuildContext context, Notification_Controller controller) {
    return Stack(
      children: [
        CustomAppBar(
            onPressedLeading: () {
              Get.back();
            },
            title: 'Notification'),
        Positioned(top: 70, child: screenStackContainer(context)),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.11,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.whit,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                // Top-left corner radius
                topRight: Radius.circular(30),
                // Bottom-right corner with no rounding
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Row(

                  children: [
                    Text(
                      "Today",
                      style:  Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:const Color(0xff333333)
                      ),
                    ),

                  ],
                ),

               if (controller.msg=="Notification not found") Container(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height/1.5,
                     child: Center(child: Text("Notification not found"),),) else Expanded(
                  child: ListView.builder(
                    itemCount:controller.notificationModel?.data.length??0,
                    shrinkWrap: true,

                    itemBuilder: (context, index) {
                      return Card(


                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [

                              Row(children: [
SizedBox(width: 10,),
                                Text("${controller.notificationModel?.data[index].createdAt.day??''}-${controller.notificationModel?.data[index].createdAt.month??''}-${controller.notificationModel?.data[index].createdAt.year??''}",style: TextStyle(fontSize: 10),),

                              ],),

                              ListTile(
                                leading:const CircleAvatar(
                                  backgroundColor: AppColors.bluecolor,
                                  radius: 24,
                                  child: Icon(
                                    Icons.notifications_active,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.7,
                                      child: Text(
                                        "${controller.notificationModel?.data[index].message??''}",
                                        style:  Theme.of(context).textTheme.titleMedium!.copyWith(
                                            color:const Color(0xff333333),
                                          fontWeight:FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: SizedBox(
                                  width: MediaQuery.of(context).size.width/1.3,
                                  child: Text(
                                    "${controller.notificationModel?.data[index].message??''}",
                                    style:  Theme.of(context).textTheme.labelMedium!.copyWith(
                                      color: Color(0xff7B7A7A)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },),
                )
              ],
            ),
          ),
        )
      ],
    );
  }


}
