import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../Constants.dart';
import '../../../Utils/Colors.dart';
import '../../../Widgets/commen_widgets.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../Utils/extentions.dart';
import '../../Widgets/app_button.dart';
import 'bookingdetails_controller.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({Key? key, this.isFrom}) : super(key: key);
  final bool? isFrom;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BookingDetailsController(),
      builder: (controller) {
        return SafeArea(
          child: Material(
            child: bodyWidget(context, controller),
          ),
        );
      },
    );
  }

  Widget bodyWidget(BuildContext context, BookingDetailsController controller) {
    return Stack(
      children: [
        CustomAppBar(
            onPressedLeading: () {
              Get.back();
            },
            title: 'Booking Details',
            notificationIcon: AppConstants.notificationIcon),
        Positioned(top: 80, child: screenStackContainer(context)),
        Positioned(
          top: 80,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // Optional: Add rounded corners
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFb6eeff).withOpacity(0.8),
                  // Shadow color
                  spreadRadius: 30,
                  // Spread radius
                  blurRadius: 20,
                  // Blur radius
                  offset: const Offset(3, 3), // Offset from the top
                ),
              ],
              border: const Border.fromBorderSide(BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 5)),
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), // Top-left corner radius
                topRight: Radius.circular(30), // Top-right corner radius
                bottomLeft:
                    Radius.circular(0), // Bottom-left corner with no rounding
                bottomRight:
                    Radius.circular(0), // Bottom-right corner with no rounding
              ),
            ),
            child: controller.bookingDetailsModel != null
                ? SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  print(
                                      '${controller.bookingDetailsModel?.data.image[0]}');
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CarouselSlider(
                                      items: controller
                                          .bookingDetailsModel?.data.image
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
                                            controller.currentIndex.value =
                                                index;
                                            controller.update();
                                          })),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: controller
                              //       .bookingDetailsModel!.data.image
                              //       .asMap()
                              //       .entries
                              //       .map((entry) {
                              //     print(entry);
                              //     print(entry.key);
                              //     return GestureDetector(
                              //       onTap: () => controller.carouselController
                              //           .animateToPage(entry.key),
                              //       child: Container(
                              //         width:
                              //             controller.currentIndex == entry.key
                              //                 ? 17
                              //                 : 7,
                              //         height: 7.0,
                              //         margin: const EdgeInsets.symmetric(
                              //           horizontal: 3.0,
                              //         ),
                              //         decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.circular(10),
                              //             color: controller.currentIndex ==
                              //                     entry.key
                              //                 ? Color(0xFF5ACBEF)
                              //                 : Colors.grey),
                              //       ),
                              //     );
                              //   }).toList(),
                              // ),
                              //
                              sliderPointers(
                                  controller.bookingDetailsModel!.data.image,
                                  controller.currentIndex.value)
                            ],
                          ),
                        ), //Sliderrrrr
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                                '${controller.bookingDetailsModel?.data.groundTitle ?? ''}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        Card(
                          child: Container(
                            // height: MediaQuery.of(context).size.height/3.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Ground',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Spacer(),
                                  const Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  /*Text(
                              'Booking Code',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),*/
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    '${controller.bookingDetailsModel?.data.groundTitle ?? ''}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xff5ACBEF)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${controller.bookingDetailsModel?.data.totalAmount ?? ''}/-',
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xff5ACBEF)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Time',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    '${controller.bookingDetailsModel?.data.bookingDate ?? ''}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xff5ACBEF)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${controller.bookingDetailsModel?.data.bookingFrom} To ${controller.bookingDetailsModel?.data.bookingTo}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xff5ACBEF)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  /*const Text(
                              'Amount',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),*/
                                  /*const Spacer(),*/

                                  controller.bookingDetailsModel?.data
                                              .bookingCancelStatus ==
                                          "null"
                                      ? const SizedBox()
                                      : const Text(
                                          'Cancellation Status',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  /*Text(
                              '${controller.bookingDetailsModel?.data.totalAmount ?? ''}/-',
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xff5ACBEF)),
                            ),*/
                                  const Spacer(),
                                  controller.bookingDetailsModel?.data
                                              .bookingCancelStatus ==
                                          "null"
                                      ? const SizedBox()
                                      : controller.bookingDetailsModel?.data
                                                  .bookingCancelStatus ==
                                              "1"
                                          ? const Text(
                                              'Booking Cancellation Pending',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff5ACBEF)),
                                            )
                                          : controller.bookingDetailsModel?.data
                                                      .bookingCancelStatus ==
                                                  "2"
                                              ? const Text(
                                                  'Booking Cancellation Approved',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xff5ACBEF)),
                                                )
                                              : const Text(
                                                  'Booking Cancellation Not Approved',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xff5ACBEF)),
                                                )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ]),
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        const Row(
                          children: [
                            Text(
                              'Facilities',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        controller.bookingDetailsModel!.data.facility.isEmpty
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: const Center(
                                  child: Text('Facilities Not Available'),
                                ),
                              )
                            : Row(
                                children: [
                                  Container(
                                    height: 50,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: controller.bookingDetailsModel
                                              ?.data.facility.length ??
                                          0,
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Text(
                                                    '${controller.bookingDetailsModel?.data.facility[index]}',
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
                                ],
                              ),

                        controller.bookingDetailsModel?.data
                                        .bookingCancelStatus ==
                                    "1" ||
                                controller.bookingDetailsModel?.data
                                        .bookingCancelStatus ==
                                    "2" ||
                                controller.bookingDetailsModel?.data
                                        .bookingCancelStatus ==
                                    "3"
                            ? const SizedBox()
                            : Column(
                                children: [
                                  controller.checkdate!.isAfter(DateTime.now())
                                      ? controller.canclebooking == false
                                          ? Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    controller.showAlertDialog(
                                                        context);
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors
                                                            .bluecolor),
                                                    child: const Center(
                                                      child: Text(
                                                          'Cancel Booking'),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )
                                          : const SizedBox()
                                      : const SizedBox(),
                                ],
                              ),

                        controller.checkdate!.isBefore(DateTime.now())
                            ? controller.canclebooking ? SizedBox() : Row(children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.offNamed(addreview,
                                    arguments: controller.groundId);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: AppColors.bluecolor),
                                child: const Center(
                                  child: Text('Add Review',style: TextStyle(color: AppColors.whit)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.onTabRaiseComplaint();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: AppColors.bluecolor),
                                child: const Center(
                                  child: Text('Raise Complaint', style: TextStyle(color: AppColors.whit),),
                                ),
                              ),
                            ),
                          ),
                        ],)
                            : const SizedBox(),

                        controller.canclebooking
                            ? Form(
                                key: controller.formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: controller.Resoncontroller,
                                      style: const TextStyle(
                                          color: AppColors.subTxtClr,
                                          fontSize: 14),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "    Please Enter Some Text";
                                        }
                                      },
                                      decoration: CustomInputDecoration
                                          .myCustomInputDecoration(
                                        hintText: controller.hint,
                                        prefixIcon: Icons.text_fields,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppButton(
                                        title: 'Submit',
                                        onTap: () {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            if(controller.hint== 'Enter Reason For Cancel Booking') {
                                              controller.canclerequest();
                                            }else {
                                              controller.raiseComplaint();
                                            }
                                          }
                                        }),
                                    const SizedBox(
                                      height: 360,
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ]),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
        ),
      ],
    );
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
}
