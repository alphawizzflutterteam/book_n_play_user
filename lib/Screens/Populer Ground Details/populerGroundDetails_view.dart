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
                            color: const Color(0xFFb6eeff)
                                .withOpacity(0.8), // Shadow color
                            spreadRadius: 30, // Spread radius
                            blurRadius: 20, // Blur radius
                            offset: const Offset(3, 3), // Offset from the top
                          ),
                        ],
                        border: const Border.fromBorderSide(BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 5)),
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
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
                                            aspectRatio: 1,
                                            viewportFraction: 1,
                                            onPageChanged: (index, reason) {
                                              controller.currentIndex.value =
                                                  index;
                                            })),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),
                                  sliderPointers(
                                      controller.groundDetailsModel!.data.image,
                                      controller.currentIndex.value)

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
                            ),
                            //Sliderrrrr
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                      color: AppColors.bluecolor,
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: AppColors.whit,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    controller.groundDetailsModel?.data.details.address ?? '',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Ground Price : ${controller.groundDetailsModel?.data.details.totalAmount ?? ''}/-',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Today Special Package',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
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
                                      ? const Center(
                                          child: Text(
                                              'No Special Offers Available'))
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
                                                .fromTime;

                                            List<String>? timeParts =
                                                timeslotoffer?.split(':');
                                            var timeslottis = timeParts?[0];

                                            TimeOfDay currentTimee = TimeOfDay(
                                                hour: int.parse(
                                                    timeslottis.toString()),
                                                minute: 0);
                                            /*TimeOfDay newTimee =
                                                currentTimee.replacing(
                                                    hour:
                                                        currentTimee.hour + 1);*/
                                            String newTimee2 = controller
                                                .groundDetailsModel
                                                ?.data
                                                .timeSlotes[index]
                                                .toTime ?? '';

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
                                                              color: const Color(
                                                                  0xFF5ACBEF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          '${currentTimee.hour}:00 To ${newTimee2}',
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          'Price : ${controller.groundDetailsModel?.data.timeSlotes[index].price}/-',
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox();
                                          },
                                        )),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Facilities',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            controller.groundDetailsModel!.data.details.facility
                                    .isEmpty
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text('No Facilities Available')],
                                  )
                                : SizedBox(
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
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Text(
                                                    '${controller.groundDetailsModel?.data.details.facility[index]}',
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                            const SizedBox(
                              height: 10,
                            ),

                            const Row(
                              children: [
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5.0), //<-- SEE HERE
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                // height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Ground',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        controller.groundDetailsModel?.data.details.title ?? '',
                                        style: const TextStyle(
                                            color: Color(0xFF5ACBEF),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        controller.groundDetailsModel?.data.details.description ?? '',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            const Row(
                              children: [
                                Text(
                                  'Today Available slots',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                             SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: (controller.groundDetailsModel?.data.timeSlotes.length ?? 0),
                                itemBuilder: (context, index) {
                                  var timeslot = controller.groundDetailsModel
                                      ?.data.timeSlotes[index].fromTime;


                                  List<String>? timeParts =
                                      timeslot?.split(':');
                                  var timeslott = timeParts?[0];

                                  TimeOfDay currentTime = TimeOfDay(
                                      hour: int.parse(timeslott.toString()),
                                      minute: 0);
                                  /*TimeOfDay newTime = currentTime.replacing(
                                      hour: currentTime.hour + 1);*/
                                  String newTime2 = controller.groundDetailsModel
                                      ?.data.timeSlotes[index].toTime ?? '';
                                  DateTime nowwdate = DateTime.now();
                                  int monthdigit = nowwdate.month;
                                  var CheckTime;
                                  if (isSingleDigit(monthdigit)) {
                                    CheckTime =
                                        "${nowwdate.year}-0${nowwdate.month}-${isSingleDigit(nowwdate.day) ?'0${nowwdate.day}' :nowwdate.day } ${controller.groundDetailsModel?.data.timeSlotes[index].fromTime}:00.000";

                                  } else {
                                    CheckTime =
                                        "${nowwdate.year}-${nowwdate.month}-${isSingleDigit(nowwdate.day) ?'0${nowwdate.day}' :nowwdate.day} ${controller.groundDetailsModel?.data.timeSlotes[index].fromTime}:00.000";

                                  }
                                  DateTime dateTimeofIndex =
                                      DateTime.parse(CheckTime);


                                  return dateTimeofIndex
                                          .isBefore(DateTime.now())
                                      ? const SizedBox.shrink()
                                      : Card(
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

                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${controller.groundDetailsModel?.data.timeSlotes[index].fromTime}',
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      const Text(
                                                        'To',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        '${newTime2}',
                                                        style: const TextStyle(
                                                            fontSize: 13),
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
                            const SizedBox(
                              height: 10,
                            ),

                            Align(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                  onTap: () {
                                    Share.shareUri(Uri.parse(
                                        '${controller.groundDetailsModel?.data.details.addressLink}'));
                                  },
                                  child: const Text(
                                    'Share Ground Location Link',
                                    style: TextStyle(
                                        color: AppColors.secondary,
                                        decoration: TextDecoration.underline),
                                  )),
                            ),

                            const SizedBox(
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
                                  child: const Text(
                                    "Book Now",
                                    style: TextStyle(
                                      //decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      primary: const Color(0xFF5ACBEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                            ),

                            const SizedBox(
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

  Widget sliderPointers(List doteList, int currentIndex) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            doteList.length,
            (index) => GestureDetector(
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
                            : Colors.grey),
                  ),
                )).toList());
  }

  bool isSingleDigit(int number) {
    return (number >= 0 && number <= 9);
  }
}
