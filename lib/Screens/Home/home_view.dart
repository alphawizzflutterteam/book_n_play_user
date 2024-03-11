import 'dart:ffi';

import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Home/HomeController.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var select;

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) => Stack(
        children: [
          screenStackContainer(context),
          RefreshIndicator(
            onRefresh: () async {
              controller.homeSlider();
              controller.homeCategory();
              controller.homeGround('');
              controller.getProfile();
            },
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.007),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        // Top-left corner radius
                        topRight: Radius.circular(30),
                        // Bottom-right corner with no rounding
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // searchWidget(controller.handleOnChangedResult),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 3,
                                    child: TextField(
                                      onChanged: (value) {
                                        controller.searchLeads(value);
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Search Ground",
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.only(top: 15),
                                          prefixIcon: const Icon(Icons.search),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  title: "Search By Time Slot",
                                                  content: GetBuilder(
                                                      init: HomeController(),
                                                      builder:
                                                          (homecontroller) {
                                                        return Form(
                                                          key: controller
                                                              .formKey,
                                                          child: Column(
                                                            children: [
                                                              controller.catList
                                                                      .isEmpty
                                                                  ? SizedBox(
                                                                      height:
                                                                          50,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:
                                                                          const Center(
                                                                        child: Text(
                                                                            'Categories Not Available'),
                                                                      ),
                                                                    )
                                                                  : SingleChildScrollView(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 1.5,
                                                                            child:
                                                                                ListView.builder(
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.horizontal,
                                                                              physics: const AlwaysScrollableScrollPhysics(),
                                                                              itemCount: controller.catList.length,
                                                                              itemBuilder: (context, index) {
                                                                                return InkWell(
                                                                                  onTap: () {
                                                                                    controller.timeslotSectcat = index;
                                                                                    // controller.update();
                                                                                    controller.selectCatIddd = controller.catList[index].id;
                                                                                    controller.update();
                                                                                  },
                                                                                  child: Card(
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: controller.timeslotSectcat == index ? AppColors.bluecolor : Colors.white,
                                                                                        boxShadow: [
                                                                                          BoxShadow(
                                                                                            color: Colors.grey.withOpacity(0.5),
                                                                                            blurRadius: 10,
                                                                                            spreadRadius: 0,
                                                                                          ),
                                                                                        ],
                                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                                      ),
                                                                                      height: 40,
                                                                                      width: 105,
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          '${controller.catList[index].title}',
                                                                                          style: TextStyle(fontSize: 13, color: controller.timeslotSectcat == index ? Colors.white : Colors.black),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                elevation: 3,
                                                                child:
                                                                    TextFormField(
                                                                  onTap: () {
                                                                    controller
                                                                        .sselectDate(
                                                                            context);
                                                                  },
                                                                  readOnly:
                                                                      true,
                                                                  controller:
                                                                      controller
                                                                          .datecontroller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              " Select Date",
                                                                          border: InputBorder
                                                                              .none,
                                                                          contentPadding: EdgeInsets.only(
                                                                              top:
                                                                                  15),
                                                                          suffixIcon:
                                                                              IconButton(
                                                                            onPressed:
                                                                                () {},
                                                                            icon:
                                                                                Icon(
                                                                              Icons.calendar_month_sharp,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return ' Please Select Date';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                elevation: 3,
                                                                child:
                                                                    TextFormField(
                                                                  onTap:
                                                                      () async {
                                                                    TimeOfDay?
                                                                        picked =
                                                                        await selectTime(
                                                                            context);
                                                                    if (picked !=
                                                                        null) {
                                                                      DateTime dateTime = DateTime(
                                                                          2020,
                                                                          10,
                                                                          10,
                                                                          picked!
                                                                              .hour,
                                                                          picked!
                                                                              .minute);
                                                                      setState(
                                                                          () {
                                                                        controller
                                                                            .timeController
                                                                            .text = "${DateFormat("HH").format(dateTime)}:00";
                                                                      });
                                                                    }
                                                                  },
                                                                  readOnly:
                                                                      true,
                                                                  controller:
                                                                      controller
                                                                          .timeController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          counterText:
                                                                              "",
                                                                          hintText:
                                                                              " Time",
                                                                          border: InputBorder
                                                                              .none,
                                                                          contentPadding: const EdgeInsets
                                                                              .only(
                                                                              top:
                                                                                  15),
                                                                          suffixIcon:
                                                                              IconButton(
                                                                            onPressed:
                                                                                () {},
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.watch_later_outlined,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return ' Please Enter Time';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            AppColors.bluecolor),
                                                                    child: const Text(
                                                                        "Back"),
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            AppColors.bluecolor),
                                                                    child: const Text(
                                                                        "Search"),
                                                                    onPressed:
                                                                        () {
                                                                      if (controller
                                                                          .formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        if (controller.selectCatIddd ==
                                                                            null) {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Select Category");
                                                                        } else {
                                                                          /*controller
                                                                              .update();*/
                                                                          controller
                                                                              .searchbytimeslot();
                                                                        }
                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }));
                                            },
                                            icon: const Icon(
                                                Icons.calendar_month_sharp),
                                          )),
                                    ),
                                  ),
                                ),
                               controller.isFilterApplied ? InkWell(
                                 onTap: (){
                                   controller.homeGround('');
                                 },
                                 child: Container(
                                    width: 60,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: const Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.clear,size: 15,color: AppColors.whit),
                                        Text('Clear',style: TextStyle(fontSize: 14,color: AppColors.whit),)

                                      ],
                                    ),
                                  ),
                               ) : const SizedBox.shrink()
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CarouselSlider(
                                      items: controller.sliderList
                                          .map(
                                            (item) => Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                  item.image ??
                                                                      "",
                                                                ),
                                                                fit: BoxFit.fill)),
                                                      )),
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColors
                                                                    .fntClr
                                                                    .withOpacity(
                                                                        0.4)),
                                                      )),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        item.title ?? '',
                                                        style: const TextStyle(
                                                            //decoration: TextDecoration.underline,
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        height: 40,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Otp_Verification()));
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  elevation: 5,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .secondary,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  )),
                                                          child: Text(
                                                            item.code ?? '',
                                                            style:
                                                                const TextStyle(
                                                              //decoration: TextDecoration.underline,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          )
                                          .toList(),
                                      carouselController:
                                          controller.carouselController,
                                      options: CarouselOptions(
                                          scrollPhysics:
                                              const BouncingScrollPhysics(),
                                          autoPlay: true,
                                          aspectRatio: 1.8,
                                          viewportFraction: 1,
                                          onPageChanged: (index, reason) {
                                            controller.currentIndex.value =
                                                index;
                                          })),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  sliderPointers(controller.sliderList,
                                      controller.currentIndex.value)
                                ],
                              ),
                            ),
                            const Text(
                              'Categories',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            // Obx(() =>  getCatListView(controller)),

                            controller.catList.isEmpty
                                ? SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(
                                      child: Text('Categories Not Available'),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount:
                                                controller.catList.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  select = index;
                                                  controller.update();
                                                  controller
                                                      .selectedCategory(index);
                                                },
                                                child: Card(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: select == index
                                                          ? AppColors.bluecolor
                                                          : Colors.white,
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
                                                    width: 105,
                                                    child: Center(
                                                      child: Text(
                                                        '${controller.catList[index].title}',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: select ==
                                                                    index
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                            const SizedBox(
                              height: 5,
                            ),
                            sliderPointers(controller.catList,
                                controller.catCurrentIndex.value),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Popular Ground",
                              style: TextStyle(
                                  color: AppColors.fntClr,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => groundListView(controller)),

                            const SizedBox(
                              height: 200,
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
        ],
      ),
    );
  }

  Widget getCatListView(HomeController catC) {
    // return catC.catList.map((e) => Card(
    //    child: Container(
    //      height: 35,
    //      width: 100,
    //      decoration: BoxDecoration(
    //        color: AppColors.whit,
    //        boxShadow: [
    //          BoxShadow(
    //            color: Colors.white.withOpacity(0.5),
    //            blurRadius: 10,
    //            spreadRadius: 0,
    //          ),
    //        ],
    //        borderRadius: BorderRadius.circular(5),
    //      ),
    //      child: Row(
    //        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //        children: [
    //
    //          Image.asset('assets/icons/football.png',scale:1.5),
    //          Text('Football')
    //        ],
    //      ),
    //
    //    ),
    //  )).toList();
    return catC.isCatLoading.value
        ? const Center(
            child: SizedBox(
              height: 60,
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(catC.catList.length, (index) {
              return InkWell(
                onTap: () {
                  catC.selectedCategory(index);
                },
                child: Card(
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      color: catC.catList[index].isSelected ?? false
                          ? AppColors.greyColor.withOpacity(0.5)
                          : AppColors.whit,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                            'assets/icons/${catC.catList[index].title?.toLowerCase()}.png',
                            scale: 1.5),
                        Text(catC.catList[index].title ?? '')
                      ],
                    ),
                  ),
                ),
              );
            })),
          );
  }

  Widget groundListView(HomeController controller) {
    return controller.isGroundLoading.value
        ? const Center(
            child: SizedBox(),
          )
        : controller.groundList.isEmpty
            ? const Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text('No ground available!')
                  ],
                ),
              )
            : SizedBox(
                // height: MediaQuery.of(context).size.height /2,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 10.0, // spacing between rows
                    crossAxisSpacing: 10.0, // spacing between columns
                  ),
                  // padding around the grid
                  itemCount: controller.groundList.length,
                  // total number of items
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Get.toNamed(groundDetailsScreen,
                              arguments: controller.groundList[index].id);
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${controller.groundList[index].image}",
                                  fit: BoxFit.fill,
                                  height: 170,
                                  width: 190,
                                )),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  //width: 190,
                                  height: 40,
                                  padding: const EdgeInsets.only(left: 5),

                                  decoration: BoxDecoration(
                                    color: AppColors.fntClr.withOpacity(0.55),
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                  ),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${controller.groundList[index].title}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: AppColors.whit)),
                                      SizedBox(
                                          width: 190,
                                          child: Text(
                                              '${controller.groundList[index].address}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.whit,
                                                  overflow:
                                                      TextOverflow.ellipsis))),
                                    ],
                                  ),
                                ))
                          ],
                        ));
                  },
                ),
              );
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    return picked;
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
