import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Bookings/my_booking_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({Key? key, this.isFrom}) : super(key: key);
final bool? isFrom ;
  @override
  Widget build(BuildContext context) {
    print('isform==============$isFrom');

    return GetBuilder(
        init: MyBookingController(),
        builder: (controller) =>
         isFrom ?? false ?
        SafeArea(
          child: Material(
                child:

                 bodyWidget(context, controller),
              ),
        )

            :
        bodyWidget2( context,  controller)
     )  ;
  }

  Widget bodyWidget(BuildContext context, MyBookingController controller) {

    print('rrrrrrrrrrrrrrrrrr');
    return

      Stack(
      children: [
        CustomAppBar(onPressedLeading: () {
          Get.back();
        },title: 'Bookings'),
        Positioned(top: 80, child: screenStackContainer(context)),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.11,),
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //searchWidget(controller.handleOnChangedResult),
                  const SizedBox(
                    height: 20,
                  ),


                  SizedBox(
                     height: MediaQuery.of(context).size.height/1.3,
                    child:

                    controller.msg=="No booking found"?Container(
                        height: MediaQuery.of(context).size.height/1.6,
                        child: Center(child: Text('No Booking Found'))):

                    ListView.builder(

                      itemCount: controller.bookingHistoryModel?.data.length??0,
                      // itemCount:1,
                      shrinkWrap: true,
                      physics:  const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(bookingdetails,arguments:
                                    {
                                      "bookingId": controller.bookingHistoryModel?.data[index].id,
                                      "GroundId":controller.bookingHistoryModel?.data[index].groundId
                                    }
                                    );
                                    // Get.toNamed(bookingdetails,arguments: controller.bookingHistoryModel?.data[index].id);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/4,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://assets.telegraphindia.com/telegraph/2021/Sep/1630669298_sky-turf.jpg',
                                        )),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                          height:MediaQuery.of(context).size.height/8,
                                        child:   Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height:07,),
                                                controller.bookingHistoryModel?.data[index].bookingName=='null'?
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      color: AppColors.whit, fontSize: 18),
                                                ):
                                                Text(
                                                  '${controller.bookingHistoryModel?.data[index].bookingName??''}',
                                                  style: TextStyle(
                                                      color: AppColors.whit, fontSize: 18),
                                                ),
                                                SizedBox(height: 12,),
                                                Text(
                                                  '${controller.bookingHistoryModel?.data[index].totalAmount??''}/-',
                                                  style: TextStyle(
                                                      color: AppColors.whit, fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(height:5,),

                                                Text(
                                                  'Date',
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 14),
                                                ),
                                                 SizedBox(height:7,),
                                                Text(
                                                  '${controller.bookingHistoryModel?.data[index].bookingDate??''}',
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 14),
                                                ),
                                                SizedBox(height:7,),
                                                Text(
                                                  '${controller.bookingHistoryModel?.data[index].bookingFrom??''} to ${controller.bookingHistoryModel?.data[index].bookingTo??''}',
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 14),
                                                ),
                                                SizedBox(height:7,),

                                              ],
                                            ),

                                          ],
                                        ))),
                              ]),
                        );

                      },),
                  ),


                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bodyWidget2(BuildContext context, MyBookingController controller) {

    print('widgit 2');
    return
      Stack(
      children: [
        screenStackContainer(context),

        Padding(
          padding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.007,),
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
            child: SingleChildScrollView(
             // physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Column(
                children: [
                 // searchWidget(controller.handleOnChangedResult),
                  const SizedBox(
                    height: 20,
                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height/1.4,
                    child:

    controller.msg=="No booking found"?Container(
        height: MediaQuery.of(context).size.height/1.6,
        child: Center(child: Text('No Booking Found'))):

                    ListView.builder(

                        itemCount: controller.bookingHistoryModel?.data.length??0,
                        // itemCount:1,
                      shrinkWrap: true,
                      physics:  const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                      return  InkWell(
                        onTap: () {

                          Get.toNamed(bookingdetails,arguments:
                          {
                            "bookingId": controller.bookingHistoryModel?.data[index].id,
                            "GroundId":controller.bookingHistoryModel?.data[index].groundId
                          }
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height/4,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://assets.telegraphindia.com/telegraph/2021/Sep/1630669298_sky-turf.jpg',
                                      )),
                                ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        height: MediaQuery.of(context).size.height/8,
                                        child:   Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height:07,),
                                                  controller.bookingHistoryModel?.data[index].bookingName=='null'?
                                                  Text(
                                                    '',
                                                    style: TextStyle(
                                                        color: AppColors.whit, fontSize: 18),
                                                  ):
                                                  Text(
                                                    '${controller.bookingHistoryModel?.data[index].bookingName??''}',
                                                    style: TextStyle(
                                                        color: AppColors.whit, fontSize: 18),
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Text(
                                                    '${controller.bookingHistoryModel?.data[index].totalAmount??''}/-',
                                                    style: TextStyle(
                                                        color: AppColors.whit, fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(height:5,),

                                                  Text(
                                                    'Date',
                                                    style: TextStyle(
                                                        color: Colors.white, fontSize: 14),
                                                  ),
                                                  SizedBox(height:7,),
                                                  Text(
                                                     '${controller.bookingHistoryModel?.data[index].bookingDate??''}',
                                                    style: TextStyle(
                                                        color: Colors.white, fontSize: 14),
                                                  ),
                                                  SizedBox(height:7,),
                                                  Text(
                                                    '${controller.bookingHistoryModel?.data[index].bookingFrom??''} to ${controller.bookingHistoryModel?.data[index].bookingTo??''}',
                                                    style: TextStyle(
                                                        color: Colors.white, fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))),
                              ]),
                        ),
                      );

                      },),
                  ),


                ],
              ),
            ),
          ),
        )

      ],
    );

  }


  Widget myBookings (){


    return

      Stack(
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Booking_details()));
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://assets.telegraphindia.com/telegraph/2021/Sep/1630669298_sky-turf.jpg',
                )),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  height: 70,
                  child:  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:07,),
                          Text(
                            'Golf Ground',
                            style: TextStyle(
                                color: AppColors.whit, fontSize: 18),
                          ),
                          SizedBox(height: 12,),
                          Text(
                            '₹ 21000',
                            style: TextStyle(
                                color: AppColors.whit, fontSize: 18),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height:5,),

                          Text(
                            'Date',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height:7,),
                          Text(
                            'Friday, 04 Oct.',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height:7,),
                          Text(
                            '1:00PM to 2:00 PM',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ))),
        ]);

  }
}
