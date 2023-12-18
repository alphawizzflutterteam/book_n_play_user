import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Models/faq_response.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FAQController extends AppBaseController {

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFAQ();
  }
  RxBool isLoading = false.obs ;
  List <FAQData> faqDataList = [] ;


  Future <void> getFAQ() async{

    isLoading.value = true;

    apiBaseHelper.getAPICall(getFAQApi).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        //Fluttertoast.showToast(msg: msg);
        faqDataList = FAQResponse.fromJson(getData).data ?? [] ;

      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading.value = false;
    });
  }

}