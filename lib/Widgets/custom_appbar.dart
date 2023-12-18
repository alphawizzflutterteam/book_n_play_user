import 'package:booknplay/Constants.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomAppBar extends StatelessWidget{
  final String? title;
  final String? notificationIcon;
  final String? leadingImage;
  final VoidCallback? onPressedLeading;
  final VoidCallback? onPressedNotification;
  final int? index;

  const CustomAppBar({
    Key? key,
    this.title,
    this.notificationIcon,
    this.leadingImage,
    this.onPressedLeading,
    this.onPressedNotification,this.index

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Container(
      width: MediaQuery.of(context).size.width,
     // padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
          // Define the colors
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          AppBar(
            //  toolbarHeight: 100,
            centerTitle: true,
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading:Center(
              child: InkWell(
                onTap: onPressedLeading,
                child: Container(
                  height: 47,
                  width: 47,
                  decoration: BoxDecoration(
                      color: AppColors.whit,
                      borderRadius: BorderRadius.circular(10)),
                  child:leadingImage == null ? Row(
                    children: [
                      SizedBox(width: 16,),
                      Icon(Icons.arrow_back_ios, color: AppColors.bluecolor,size: 20,),
                    ],
                  ):Center(child:  Icon(Icons.sort, color: AppColors.bluecolor,)) ,
                  // IconButton(
                  //   onPressed: (){
                  //     Get.toNamed(notificationscr);
                  //   },
                  //   icon:leadingImage == null ? Center(child: const Icon(Icons.arrow_back_ios, color: AppColors.bluecolor,)):Center(child: const Icon(Icons.sort, color: AppColors.bluecolor,)) ,
                  // ),


                ),
              ),
            ),
            /*leading: Center(
                child: InkWell(
                  onTap: onPressedLeading,
                  child: leadingImage == null ? const Icon(Icons.arrow_back_ios, color: AppColors.whit,) :  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: AppColors.whit,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(leadingImage!, scale: 1.7),
                  ),
                ),
              ),*/
            title: Text(
              title ?? 'Please Wait...',
              style: const TextStyle(
                color: AppColors.whit,
                fontSize: 20.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            actions: [
              notificationIcon != null ?Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.whit,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    onPressed: (){
                      Get.toNamed(notificationscr);
                    },
                    icon: const Icon(Icons.notifications_active, color: AppColors.bluecolor,) ,
                  ),
                ),
              ): const SizedBox.shrink(),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

}




class CustomAppBar1 extends StatelessWidget{
  final String? title;
  final String? notificationIcon;
  final String? leadingImage;
  final VoidCallback? onPressedLeading;
  final VoidCallback? onPressedNotification;
  final int? index;

  const CustomAppBar1({
    Key? key,
    this.title,
    this.notificationIcon,
    this.leadingImage,
    this.onPressedLeading,
    this.onPressedNotification,this.index

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Container(
        width: MediaQuery.of(context).size.width,
        //padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 100,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
            // Define the colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            AppBar(
            //  toolbarHeight: 100,
              toolbarHeight: 70,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
          leading:Center(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.whit,
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: onPressedLeading,
                icon: leadingImage == null ? const Icon(Icons.arrow_back_ios, color: AppColors.bluecolor,):const Icon(Icons.sort, color: AppColors.bluecolor,) ,
              ),
            ),
          ),
              /*leading: Center(
                child: InkWell(
                  onTap: onPressedLeading,
                  child: leadingImage == null ? const Icon(Icons.arrow_back_ios, color: AppColors.whit,) :  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: AppColors.whit,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(leadingImage!, scale: 1.7),
                  ),
                ),
              ),*/
              title: Text(
                title ?? 'Please Wait...',
                style: const TextStyle(
                  color: AppColors.whit,
                  fontSize: 20.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              actions: [
                notificationIcon != null ?Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whit,
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      onPressed: (){
                        Get.toNamed(notificationscr);
                      },
                      icon: const Icon(Icons.notifications_active, color: AppColors.bluecolor,) ,
                    ),
                  ),
                ): const SizedBox.shrink(),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      );
  }

}
