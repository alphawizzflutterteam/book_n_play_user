import 'dart:convert';

import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/auth_response_model.dart';
import '../../../Routes/routes.dart';

class OTPVerifyController extends AppBaseController{




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    data = Get.arguments ;

    otp=data[1].toString();
  }

RxBool isLoading = false.obs ;
  List data = [] ;
  var otp;
  var textotp;


  Future<void> verifyOTP() async {


    SharedPreferences preferences = await SharedPreferences.getInstance();
    var  devvicekey = preferences.getString('deviceToken');
    isLoading.value = true ;

    var param = {
      'contact': data[0].toString(),
      'otp': otp,
      'device_key': "${devvicekey.toString()}"
    };
    apiBaseHelper.postAPICall(verifyOTPAPI, param).then((getData) {


      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        User? userData = User();

        userData = User.fromJson(getData['user']);

        SharedPre.setValue(SharedPre.userData, userData.toJson());
        // SharedPre.setValue('userData', jsonEncode(getData['user']));
        // SharedPre.setValue('userId', getData['user']['id'].toString());
        SharedPre.setValue(SharedPre.isLogin, true);

        Fluttertoast.showToast(msg: msg);
        Get.offAllNamed(bottomBar);


      } else {

        Fluttertoast.showToast(msg: msg);

      }
      isLoading.value = false ;
    });
  }

  Future<void> sendOtp({required String mobile}) async {
    isLoading.value = true;

    var param = {
      'contact': mobile,
    };
    apiBaseHelper.postAPICall(sendOTPAPI, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg);
otp=getData['otp'].toString();
update();
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading.value = false;
    });
  }
}