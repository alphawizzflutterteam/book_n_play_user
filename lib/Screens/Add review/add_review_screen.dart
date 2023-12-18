import 'package:booknplay/Screens/FAQ/faq_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'add_review_controller.dart';

class AddReviewScreen extends StatelessWidget {
  AddReviewScreen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Add_reviewController(),
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

  Widget bodyWidget(BuildContext context, Add_reviewController controller) {
    return Stack(
      children: [
        CustomAppBar(
            onPressedLeading: () {
              Get.back();
            },
            title: 'Add Review'),
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
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [


    RatingBar(
    initialRating: 0,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    ratingWidget: RatingWidget(
    full: Image.asset('assets/images/star.png'),
    half: Image.asset('assets/images/rating.png'),
    empty: Image.asset('assets/images/star2.png'),
    ),
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    onRatingUpdate: (rating) {
    print(rating);
    controller.review=rating;
    controller.update();
    },
    ),

                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
                      ),
                      child: Expanded(
                        child: Container(
                          width: double.infinity,
                          // height: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [



                               TextFormField(
                                 controller: controller.addreviewcontroller,
                                 maxLines: 4,
                                 style: const TextStyle(overflow: TextOverflow.ellipsis),
                                 decoration: InputDecoration(
counterText: "",
                                     border: InputBorder.none,

                                     hintText: "Write Here..."),

                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return 'Please enter some text';
                                   }
                                   return null;
                                 },

                               ),

                                SizedBox(
                                  height: 10,
                                ),



                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
SizedBox(height: 60,),
                    InkWell(
                      onTap: () {
if(controller.formKey.currentState!.validate())
  {
   if(controller.review==null){

     Fluttertoast.showToast(msg: "Please Select Star Rating");
   }
   else{

     controller.addReview();
   }


  }

                      },
                      child: Container(width:200,height: 50,

                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.bluecolor),

                        child: Center(child: Text('Add Review'),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }


}
