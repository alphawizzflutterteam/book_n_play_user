import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Models/auth_response_model.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupController extends AppBaseController {
  RxBool isLoading = false.obs ;
  Future<void> registerUser(
      {required String email,
      required String mobile,
      required String password,
      required String? name}) async {
    isLoading.value = true ;

    var param = {
      'email': email,
      'name': name,
      'mobile': mobile,
      'password': password,
      'device_key': mobile,

    };
    apiBaseHelper.postAPICall(getUserRegister, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['message'];

      if (status) {
        Fluttertoast.showToast(msg: msg);
        User? userData = User();

        userData = User.fromJson(getData['user']);

        SharedPre.setValue(SharedPre.userData, userData.toJson());
        SharedPre.setValue(SharedPre.isLogin, true);

        // SharedPre.setValue('userData', jsonEncode(getData['user']));
        Get.offAllNamed(bottomBar);

      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading.value = false ;
    });
  }
}
