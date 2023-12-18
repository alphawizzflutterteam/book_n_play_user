import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'no_internetconnection_controller.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.sizeOf(context).height;
    final widthSize = MediaQuery.sizeOf(context).width;
    return GetBuilder(
      init: NoInternetscrController(),
      builder: (controller) {
        return Scaffold(
          body:

              RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 2),() {
                    print('raj');
                    Get.offAllNamed(splashScreen);
                  },);
                },
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                  return

                    Container(

                      height: heightSize,
                      width: widthSize,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary,AppColors.secondary, ], // Define the colors
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,

                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 100,),
                          Image.asset('assets/images/no-internet-error.png',scale: 2,),

                          SizedBox(height: 20,),
                          Text('Oops! There is No Internet Connection',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(height: 70,),
                          InkWell(
                            onTap: () {
                              print('raj');
                              Get.offAllNamed(splashScreen);
                            },
                            child: Container(height: 50,width: 200,

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),

                                  color:AppColors.bluecolor
                              ),
                              child: Center(child: Text('Tab For Refresh')),
                            ),
                          )
                        ],
                      ),

                    );
                },),
              ),

        );
      },) ;
  }
}