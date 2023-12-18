import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TermsAndConditionController extends AppBaseController{



  RxBool isLoading = false.obs;
  var data;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    termsCondition();
  }

  Future<void> termsCondition() async{

    apiBaseHelper.getAPICall(getTermsAPI).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        data = getData['data'][0]['description'];
        update();
      } else {
      }
      isLoading.value = false;
    });
  }

}