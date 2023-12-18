import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PrivacyController extends AppBaseController{



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    termsCondition();
  }
  RxBool isLoading = false.obs;
  var data;
Future<void> termsCondition() async{


  apiBaseHelper.getAPICall(getPrivacyPolicyAPI).then((getData) {
    print('=============$getData');
    bool error = getData['status'];
    String msg = getData['message'];

    if (error) {
       data = getData['data'][0]['description'];
       print('privecy html data =========$data');
       update();

    } else {
    }
    isLoading.value = false;
  }

  );
}
}