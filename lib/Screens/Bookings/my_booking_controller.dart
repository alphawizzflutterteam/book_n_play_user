import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/auth_response_model.dart';
import '../../Models/bookingModel/bookingHistoryModel.dart';
import '../../Services/api_services/apiStrings.dart';

class MyBookingController extends AppBaseController{

  bool? isFrom;
  String? onSearch;
  User usedata = User();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
     isFrom = Get.arguments ;

     print('${isFrom}_________drawer___');
    var obj = await SharedPre.getObjs(SharedPre.userData);

    usedata = User.fromJson(obj);
    getBookingHistory('0');

  }


  void handleOnChangedResult(String? result) {

    onSearch = result;





  }
int selectedSegmentVal = 0 ;
  setSegmentValue(int i) {
    selectedSegmentVal = i;
    String status;
    if (i == 0) {
      getBookingHistory('0');
      //parcelHistory(1);
    } else if (i == 1) {

      getBookingHistory('1');
      //parcelHistory(2);
    }
update();
    // getOrderList(status: status);
  }

  BookingHistoryModel?bookingHistoryModel;
  String ?msg;
  Future<void> getBookingHistory( String status) async{

    var param = {
            'user_id': usedata.id.toString(),
          'status': status,
    };
    apiBaseHelper.postAPICall(GetBookingHistory, param).then((getData) {
      bool error = getData['status'];
      msg = getData['message'];
      update();
      if (error) {
        // Fluttertoast.showToast(msg: msg.toString());
        bookingHistoryModel=BookingHistoryModel.fromJson(getData);
        update();

      } else {

        // Fluttertoast.showToast(msg: msg.toString());
      }
    });

  }


}

