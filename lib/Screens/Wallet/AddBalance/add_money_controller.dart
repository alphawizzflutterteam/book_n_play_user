import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Wallet/AddBalance/confirm_payment_screen.dart';
import 'package:booknplay/Screens/Wallet/my_wallet_controller.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class AddMoneyController extends AppBaseController {

  final walletController = Get.find<MyWalletController>() ;

  final addMoneyController = TextEditingController() ;
  Razorpay? _razorpay;
  int? pricerazorpayy;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {



    addBalance(response.paymentId.toString());


  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    addBalance(response.walletName.toString());
  }

  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy = int.parse(res.toStringAsFixed(0)) * 100;
    print("checking razorpay price ${pricerazorpayy.toString()}");
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': pricerazorpayy,
      'name': 'Book And Play',
      'image': 'assets/images/splash_logo.png',
      'description': 'Book And Play',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  RxBool isLoading = false.obs ;

  Future <void> addBalance(String tranjectionId) async{

    var param = {
      'user_id': walletController.usedata.id.toString(),
      'amount':addMoneyController.text,
      'transaction_id':'${tranjectionId}'
    };
    isLoading.value = true;


    apiBaseHelper.postAPICall(fetchProductByFillters, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
       // Fluttertoast.showToast(msg: msg);
        Get.to(const ConfirmPaymentScreen());
       // return;
       // Get.offAllNamed(bottomBar);
        // transactionHistoryData = TransactionHistoryResponse.fromJson(getData).data ;

      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading.value = false;
    });
  }


}