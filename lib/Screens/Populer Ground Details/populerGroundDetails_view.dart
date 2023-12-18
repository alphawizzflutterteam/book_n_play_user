import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Populer%20Ground%20Details/populerGroundDeatails_Controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Constants.dart';
import '../../../Widgets/commen_widgets.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../Utils/Colors.dart';

class GroundDetailsScreen extends StatelessWidget {
  const GroundDetailsScreen({Key? key, this.isFrom}) : super(key: key);
  final bool? isFrom;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PopulerGroundDetailsController(),
      builder: (controller) {
        return SafeArea(
          child: Material(
            child: bodyWidget(context, controller),
          ),
        );
      },
    );
  }

  Widget bodyWidget(
      BuildContext context, PopulerGroundDetailsController controller) {
    return Obx(() => Stack(
          children: [
            CustomAppBar(
                onPressedLeading: () {
                  Get.back();
                },
                title: !controller.loading.value
                    ? controller.groundDetailsModel?.data.details.title ?? ''
                    : "",
                notificationIcon: AppConstants.notificationIcon),
            Positioned(top: 80, child: screenStackContainer(context)),
            Positioned(
              top: 80,
              child: !controller.loading.value
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        // Optional: Add rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFb6eeff)
                                .withOpacity(0.8), // Shadow color
                            spreadRadius: 30, // Spread radius
                            blurRadius: 20, // Blur radius
                            offset: Offset(3, 3), // Offset from the top
                          ),
                        ],
                        border: Border.fromBorderSide(BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 5)),
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(30), // Top-left corner radius
                          topRight:
                              Radius.circular(30), // Top-right corner radius
                          bottomLeft: Radius.circular(
                              0), // Bottom-left corner with no rounding
                          bottomRight: Radius.circular(
                              0), // Bottom-right corner with no rounding
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [


                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CarouselSlider(
                                        items: controller
                                            .groundDetailsModel?.data.image
                                            .map(
                                              (item) => Image.network(
                                                "${item}",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            )
                                            .toList(),
                                        carouselController:
                                            controller.carouselController,
                                        options: CarouselOptions(
                                            scrollPhysics:
                                                const BouncingScrollPhysics(),
                                            autoPlay: true,
                                            aspectRatio: 2,
                                            viewportFraction: 1,
                                            onPageChanged: (index, reason) {
                                              controller.currentIndex.value = index;
                                            })),
                                  ),


                                  const SizedBox(
                                    height: 8,
                                  ),
                                  sliderPointers (controller.groundDetailsModel!.data.image , controller.currentIndex.value )

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: List.generate(
                                  //       controller.groundDetailsModel!.data
                                  //           .image.length,
                                  //       (index) => GestureDetector(
                                  //             onTap: () => controller
                                  //                 .carouselController
                                  //                 .animateToPage(index),
                                  //             child: Container(
                                  //               width:
                                  //                   controller.currentIndex.value ==
                                  //                           index
                                  //                       ? 17
                                  //                       : 7,
                                  //               height: 7.0,
                                  //               margin:
                                  //                   const EdgeInsets.symmetric(
                                  //                 horizontal: 3.0,
                                  //               ),
                                  //               decoration: BoxDecoration(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           10),
                                  //                   color: controller
                                  //                               .currentIndex.value ==
                                  //                           index
                                  //                       ? Color(0xFF5ACBEF)
                                  //                       : Colors.grey),
                                  //             ),
                                  //           )).toList(),
                                  // ),
                                ],
                              ),
                            ), //Sliderrrrr
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: AppColors.bluecolor,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.location_on,
                                    color: AppColors.whit,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    '${controller.groundDetailsModel?.data.details.address ?? ''}',
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                                  ),
                                ),

                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Ground Price : ${controller.groundDetailsModel?.data.details.totalAmount ?? ''}/-',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Special Package',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            // Card(
                            //   elevation: 5,
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
                            //   ),
                            //   child: Container(
                            //     width: 400,
                            //     height: 100,
                            //     child: Padding(
                            //       padding:
                            //           const EdgeInsets.only(left: 20, right: 20, top: 10),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Container(
                            //                 height: 10,
                            //                 width: 10,
                            //                 decoration: BoxDecoration(
                            //                     color: Color(0xFF5ACBEF),
                            //                     borderRadius: BorderRadius.circular(100)),
                            //               ),
                            //               SizedBox(
                            //                 width: 20,
                            //               ),
                            //               Text(
                            //                 'First 15 days - 25% off',
                            //                 style: TextStyle(
                            //                     fontSize: 15,
                            //                     fontWeight: FontWeight.w500),
                            //               ),
                            //             ],
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           Row(
                            //             children: [
                            //               Container(
                            //                 height: 10,
                            //                 width: 10,
                            //                 decoration: BoxDecoration(
                            //                     color: Color(0xFF5ACBEF),
                            //                     borderRadius: BorderRadius.circular(100)),
                            //               ),
                            //               SizedBox(
                            //                 width: 20,
                            //               ),
                            //               Text(
                            //                 'Last 15 days - 15% off',
                            //                 style: TextStyle(
                            //                     fontSize: 15,
                            //                     fontWeight: FontWeight.w500),
                            //               ),
                            //             ],
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           Row(
                            //             children: [
                            //               Container(
                            //                 height: 10,
                            //                 width: 10,
                            //                 decoration: BoxDecoration(
                            //                     color: Color(0xFF5ACBEF),
                            //                     borderRadius: BorderRadius.circular(100)),
                            //               ),
                            //               SizedBox(
                            //                 width: 20,
                            //               ),
                            //               Text(
                            //                 'Full Month- 50% off',
                            //                 style: TextStyle(
                            //                     fontSize: 15,
                            //                     fontWeight: FontWeight.w500),
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            //

                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5.0), //<-- SEE HERE
                              ),
                              child: Container(
                                  width: 400,
                                  height: 100,
                                  padding: const EdgeInsets.all(8.0),
                                  child: controller.isoffer.isEmpty
                                      ? Center(
                                          child: Text(
                                              'No Special Offers Avaiable'))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: controller
                                              .groundDetailsModel
                                              ?.data
                                              .timeSlotes
                                              .length,
                                          itemBuilder: (context, index) {
                                            var timeslotoffer = controller
                                                .groundDetailsModel
                                                ?.data
                                                .timeSlotes[index]
                                                .time;

                                            List<String>? timeParts =
                                                timeslotoffer?.split(':');
                                            var timeslottis = timeParts?[0];

                                            TimeOfDay currentTimee = TimeOfDay(
                                                hour: int.parse(
                                                    timeslottis.toString()),
                                                minute: 0);
                                            TimeOfDay newTimee =
                                                currentTimee.replacing(
                                                    hour:
                                                        currentTimee.hour + 1);

                                            return controller
                                                        .groundDetailsModel
                                                        ?.data
                                                        .timeSlotes[index]
                                                        .isOffer ==
                                                    1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 10,
                                                          width: 10,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF5ACBEF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          '${currentTimee.hour}:00 To ${newTimee.hour}:00',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          'Price : ${controller.groundDetailsModel?.data.timeSlotes[index].price}/-',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox();
                                          },
                                        )),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Facilities',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            controller.groundDetailsModel!.data.details.facility
                                    .isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text('No Facilities Avaiable')],
                                  )
                                : Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: controller.groundDetailsModel
                                          ?.data.details.facility.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 10,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            height: 40,
                                            // width: 105,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: Text(
                                                    '${controller.groundDetailsModel?.data.details.facility[index]}',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5.0), //<-- SEE HERE
                              ),
                              child: Container(
                                width: double.infinity,
                                // height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ground',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '${controller.groundDetailsModel?.data.details.title ?? ''}',
                                        style: TextStyle(
                                            color: Color(0xFF5ACBEF),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${controller.groundDetailsModel?.data.details.description ?? ''}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Text(
                                  'Available time slots',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: controller.groundDetailsModel?.data
                                        .timeSlotes.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  var timeslot = controller.groundDetailsModel
                                      ?.data.timeSlotes[index].time;

                                  print('time=======${timeslot}');

                                  List<String>? timeParts =
                                      timeslot?.split(':');
                                  var timeslott = timeParts?[0];
                                  print(
                                      "currenttime===================${timeslott}");

                                  TimeOfDay currentTime = TimeOfDay(
                                      hour: int.parse(timeslott.toString()),
                                      minute: 0);
                                  TimeOfDay newTime = currentTime.replacing(
                                      hour: currentTime.hour + 1);

                                  return Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: controller
                                                    .groundDetailsModel
                                                    ?.data
                                                    .timeSlotes[index]
                                                    .isBooked !=
                                                1
                                            ? Colors.greenAccent
                                            : Colors.grey,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),

                                      height: 40,

                                      // width: 105,

                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${controller.groundDetailsModel?.data.timeSlotes[index].time}',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  'To',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  '${newTime.hour}:00',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10,),

                            Align(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                  onTap: (){
                                    Share.shareUri(Uri.parse('${controller.groundDetailsModel?.data.details.addressLink}'));
                                  },
                                  child: const Text('Share Ground Location Link', style: TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),)),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            Center(
                              child: Container(
                                width: 300,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(bookingFormScreen, arguments: {
                                      "groundId": controller.groundId,
                                      "totlaPrice": controller
                                          .groundDetailsModel
                                          ?.data
                                          .details
                                          .totalAmount
                                    });
                                  },
                                  child: Text(
                                    "Book Now",
                                    style: TextStyle(
                                      //decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      primary: Color(0xFF5ACBEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 200,
                            )
                          ]),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
          ],
        ));
  }

  Widget sliderPointers (List doteList , int currentIndex ) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:List.generate(doteList.length, (index) => GestureDetector(
          // onTap:()=> controller.carouselController.animateToPage(entry.key),
          child: Container(
            width: currentIndex == index ? 25 : 12,
            height: 4.0,
            margin: const EdgeInsets.symmetric(
              horizontal: 3.0,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentIndex == index
                    ? AppColors.secondary
                    : Colors.grey
            ),
          ),
        )).toList());
  }
}
