import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/auth_response_model.dart';
import '../../Models/nitificationModel.dart';
import '../../Services/api_services/apiStrings.dart';

class Notification_Controller extends AppBaseController {


  User usedata = User();
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    var obj = await SharedPre.getObjs(SharedPre.userData);

    usedata = User.fromJson(obj);

    getNotification();
  }



  var msg;
  NotificationModel?notificationModel;
  TextEditingController addreviewcontroller =TextEditingController();
  Future <void> getNotification() async{

    var param = {
      'user_id': usedata.id.toString(),
    };
    apiBaseHelper.postAPICall(GetNotification, param).then((getData) {
      print(getData);
      bool error = getData['status'];
      msg = getData['message'];
      update();
      if (error) {

        notificationModel=NotificationModel.fromJson(getData);


      } else {

      }
    });
  }

}