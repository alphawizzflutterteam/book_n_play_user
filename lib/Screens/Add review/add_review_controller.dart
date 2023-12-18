import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/auth_response_model.dart';

class Add_reviewController extends AppBaseController {


  User usedata = User();
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    var obj = await SharedPre.getObjs(SharedPre.userData);

    usedata = User.fromJson(obj);
    groundIddd=Get.arguments.toString();
  }
  final formKey = GlobalKey<FormState>();

  var review;
  var msg;
  String?groundIddd;

  TextEditingController addreviewcontroller =TextEditingController();
  Future <void> addReview() async{

    var param = {
      'user_id': usedata.id.toString(),
      'ground_id': groundIddd.toString(),
      'rating': review.toString(),
      'review': addreviewcontroller.text
    };
    apiBaseHelper.postAPICall(Addreview, param).then((getData) {
      print(getData);
      bool error = getData['status'];
      msg = getData['message'];
      update();
      if (error) {


    Fluttertoast.showToast(msg: msg.toString());
Get.offNamed(bottomBar);

      } else {

         Fluttertoast.showToast(msg: msg.toString());
      }
    });
  }

}