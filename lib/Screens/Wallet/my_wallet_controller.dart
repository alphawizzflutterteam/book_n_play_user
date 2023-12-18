import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Models/auth_response_model.dart';
import 'package:booknplay/Models/transaction_history_response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../Services/api_services/apiStrings.dart';

class MyWalletController extends AppBaseController{
  User usedata = User();

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    var obj = await SharedPre.getObjs(SharedPre.userData);

    usedata = User.fromJson(obj);
    getBalance();

  }

  RxBool isLoading = false.obs ;

  TransactionHistoryResponse? transactionHistoryResponse;

  Future <void> getBalance() async{

    var param = {
      'user_id': usedata.id.toString(),
    };
    isLoading.value = true;


    apiBaseHelper.postAPICall(getTransactionApi, param).then((getData) {



      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        //Fluttertoast.showToast(msg: msg);
        transactionHistoryResponse =TransactionHistoryResponse.fromJson(getData);

      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading.value = false;
    });
  }


}