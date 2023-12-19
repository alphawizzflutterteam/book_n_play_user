import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../Constants.dart';
import '../../../Widgets/commen_widgets.dart';
import '../../../Widgets/custom_appbar.dart';
import 'bookingForm_controller.dart';

class BookingFormScreen extends StatelessWidget {
  const BookingFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BookingFormController(),
      builder: (controller) {
        return SafeArea(
          child: Material(
            child: bodyWidget(context, controller),
          ),
        );
      },
    );
  }

  Widget bodyWidget(BuildContext context, BookingFormController controller) {
    return Stack(
      children: [
        CustomAppBar(
          onPressedLeading: () {
            Get.back();
          },
          title: 'Booking Form',
        ),
        Positioned(top: 80, child: screenStackContainer(context)),
        Positioned(
          top: 80,
          child: Container(
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // Optional: Add rounded corners
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFb6eeff).withOpacity(0.8), // Shadow color
                  spreadRadius: 30, // Spread radius
                  blurRadius: 20, // Blur radius
                  offset: Offset(3, 3), // Offset from the top
                ),
              ],
              border: Border.fromBorderSide(BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 5)),
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), // Top-left corner radius
                topRight: Radius.circular(30), // Top-right corner radius
                bottomLeft:
                    Radius.circular(0), // Bottom-left corner with no rounding
                bottomRight:
                    Radius.circular(0), // Bottom-right corner with no rounding
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Select Date",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        controller.sselectDate(context);
                      },
                      autofocus: false,
                      controller: controller.datecontroller,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month_sharp,
                              color: Colors.grey),
                          hintText: "Select Booking Date",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Select Time",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    controller.timeSlot2.isEmpty
                        ? Container(
                            height: 50,
                            child: Center(
                              child: Text('Please Select Date'),
                            ),
                          )
                        : Container(
                            height: 50,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: controller.timeSlot2.length,
                              itemBuilder: (context, index) {



                                var timeslot = controller.timeSlot2[index].time;

                                List<String>? timeParts = timeslot?.split(':');
                                var timeslott = timeParts?[0];

                                TimeOfDay currentTime = TimeOfDay(
                                    hour: int.parse(timeslott.toString()),
                                    minute: 0);
                                TimeOfDay newTime = currentTime.replacing(
                                    hour: currentTime.hour + 1);

                                var CheckTime =
                                    "${controller.datecontroller.text} ${controller.timeSlot2[index].time}:00.000";

                                DateTime dateTimeofIndex =
                                    DateTime.parse(CheckTime);


                                DateTime dateTimechek =
                                    DateTime.parse("2023-11-20 00:00:00.000");

                                return


                                  dateTimeofIndex.isBefore(DateTime.now())
                                    ? SizedBox()
                                    : controller.timeSlot2[index].isBooked != 1
                                        ?

                                  InkWell(
                                            onTap: () {

                                              controller.tabIndex = index;
                                              controller.update();
                                              var timeslotA = controller
                                                  .timeSlot2[index].time;

                                              List<String>? timeParts =
                                                  timeslotA.split(':');
                                              var timeslott = timeParts[0];

                                              TimeOfDay currentTime1 =
                                                  TimeOfDay(
                                                      hour: int.parse(
                                                          timeslott.toString()),
                                                      minute: 0);
                                              controller.selectTimeFrom =
                                                  "${currentTime1.hour}:00";
                                              TimeOfDay newTime =
                                                  currentTime.replacing(
                                                      hour: currentTime1.hour +
                                                          1);
                                              controller.selectTimeTo =
                                                  "${newTime.hour}:00";
                                              controller.update();
                                            },
                                            child: Card(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          controller.tabIndex ==
                                                                  index
                                                              ? Colors.black
                                                              : Colors.white,
                                                      width: 2),
                                                  color: controller
                                                              .timeSlot2[index]
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
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),

                                                height: 40,

                                                // width: 105,

                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${controller.timeSlot2[index].time}',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            'To',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            '${newTime.hour}:00',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'This Time Slot Not Available Please Select Other Time Slot');
                                            },
                                            child: Card(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          controller.tabIndex ==
                                                                  index
                                                              ? Colors.black
                                                              : Colors.white,
                                                      width: 2),
                                                  color: controller
                                                              .timeSlot2[index]
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
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),

                                                height: 40,

                                                // width: 105,

                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${controller.timeSlot2[index].time}',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            'To',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            '${newTime.hour}:00',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                              },
                            ),
                          ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ), //
                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      autofocus: false,
                      controller: controller.namecontroller,
                      decoration: InputDecoration(
                          hintText: 'Enter Name',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Email id",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: controller.emailcontroller,
                      decoration: InputDecoration(
                          hintText: 'Enter Email id',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email Id';
                        } else if (!value.contains("@") &&
                            !value.contains(".com")) {
                          return 'Please Enter Valid  Email Id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Phone Number",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ), //
                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      maxLength: 10,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      controller: controller.mobilcontroller,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: 'Enter Phone Number',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Phone Number';
                        } else if (value.length < 10) {
                          return 'Please Enter Vailed';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Address",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ), //

                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      autofocus: false,
                      controller: controller.addresscontroller,
                      decoration: InputDecoration(
                          hintText: "",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Apply Promo Code",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ), //

                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 6,

                      autofocus: false,
                      controller: controller.promocodeController,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "Apply Promo Code",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0))),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Enter Promocode';
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) {
                        if (value.length == 6) {
                          controller.Applypromo();
                        }
                      },
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
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.selectTimeFrom == null) {
                                Fluttertoast.showToast(
                                    msg: 'Please Select Time Slot');
                              } else {
                                controller.BookGround();
                              }
                            }
                          },
                          child: Text(
                            "Submit",
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
                      height: 350,
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
