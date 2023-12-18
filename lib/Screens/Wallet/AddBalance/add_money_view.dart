import 'package:booknplay/Screens/Wallet/AddBalance/add_money_controller.dart';
import 'package:booknplay/Screens/Wallet/AddBalance/confirm_payment_screen.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init: AddMoneyController(),
      builder: (controller) =>   SafeArea(child: Material(

        child: bodyWidget( context , controller ),

      )),);
  }

  Widget bodyWidget(BuildContext context ,AddMoneyController controller ) {
    return Stack(children: [

      CustomAppBar(
          onPressedLeading: () {
            Get.back();
          },
          title: 'Wallet'),
      Positioned(top: 70, child: screenStackContainer(context)),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.11,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: AppColors.whit,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              // Top-left corner radius
              topRight: Radius.circular(30),
              // Bottom-right corner with no rounding
            ),
          ),
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AVAILABLE WALLET BALANCE-  ₹ ${controller.walletController.transactionHistoryResponse?.data.wallet}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                const SizedBox(height: 20,),
                const Text('Amount',style: TextStyle(
                    color: Color(0xff5B5B5B),
                    fontWeight: FontWeight.w400,
                    fontSize:18),),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: TextFormField(
                    controller: controller.addMoneyController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      hintText: '',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(top: 0,left: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Padding(padding: const EdgeInsets.all(30),child: AppButton(title: 'Proceed to Add', onTap: (){

                  if(controller.addMoneyController.text.isEmpty)
                    {
                      Fluttertoast.showToast(msg: 'Please Enter Amount');

                    }
                  else{

                    controller.openCheckout(controller.addMoneyController.text);
                  }


                }),),

                // _buildExpansionTile( 0),

              ],
            ),
          ),

        ),
      )
    ],);
  }
}
