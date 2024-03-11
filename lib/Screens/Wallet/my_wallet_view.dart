import 'package:booknplay/Constants.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Wallet/my_wallet_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyWalletController(),
      builder: (controller) => SafeArea(
        child: Material(
          child: bodyWidget(controller, context),
        ),
      ),
    );
  }

  Widget bodyWidget(MyWalletController controller, BuildContext context) {
    return Stack(
      children: [
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
            child: Obx(
              () => SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: controller.isLoading.value
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ))
                    : Column(
                        children: [
                          const Text(
                            'Available Balance',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '₹ ${controller.transactionHistoryResponse?.data.wallet.toString() ?? ''}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: AppButton(
                              onTap: () {
                                Get.toNamed(addMoneyScreen);
                              },
                              title: 'Add to Wallet',
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Transaction',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              )),
                          const SizedBox(
                            height: 10,
                          ),

                          controller.transactionHistoryResponse?.data
                                      .transactions.isEmpty ??
                                  false
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: const Center(
                                      child: Text(
                                          "Transaction history not available")),
                                )
                              : ListView.builder(
                                  itemCount: controller
                                          .transactionHistoryResponse
                                          ?.data
                                          .transactions
                                          .length ??
                                      0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var item = controller
                                        .transactionHistoryResponse
                                        ?.data
                                        .transactions[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 0.5,
                                                    offset: const Offset(0, 1),
                                                    blurRadius: 2)
                                              ]),
                                          child: Center(
                                            child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              leading: Image.asset(
                                                  AppConstants.hockeyIcon),
                                              title: Text(
                                                item?.transactionId == ''
                                                    ? item?.transactionType ??
                                                        ''
                                                    : item?.transactionId ?? '',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('${item?.createdAt}'),
                                                  Text('${item?.destination}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          color: item?.transactionType
                                                                      .toLowerCase() ==
                                                                  "credit"
                                                              ? Colors.green
                                                              : Colors.red))
                                                ],
                                              ),
                                              trailing: Text(
                                                '${item?.amount}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: item?.transactionType
                                                                .toLowerCase() ==
                                                            "credit"
                                                        ? Colors.green
                                                        : Colors.red),
                                              ),
                                            ),
                                          )),
                                    );
                                  },
                                )

                          // _buildExpansionTile( 0),
                        ],
                      ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
