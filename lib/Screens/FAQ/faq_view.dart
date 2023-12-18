import 'package:booknplay/Screens/FAQ/faq_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FAQController(),
      builder: (controller) => SafeArea(
          child: Material(
        child: bodyWidget(context, controller),
      )),
    );
  }

  List<Widget> _buildExpansionTileChildren(FAQController controller, int index) => [
        Container(
          padding: const EdgeInsets.all(20),
          child:  Text(controller.faqDataList[index].description ?? '',
            textAlign: TextAlign.justify,
          ),
        ),
      ];

  Widget bodyWidget(BuildContext context, FAQController controller) {
    return Stack(
      children: [
        CustomAppBar(
            onPressedLeading: () {
              Get.back();
            },
            title: 'FAQ'),
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
                children: [
                  // _buildExpansionTile( 0),
                  Obx(
                    () =>  controller.isLoading.value ? Container(

                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(child: CircularProgressIndicator(color: AppColors.primary),))  :SizedBox(
                      // height: MediaQuery.of(context).size.height/1.6,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: controller.faqDataList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _buildExpansionTile(index, controller);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildExpansionTile(int index, FAQController controller) {
    final GlobalKey expansionTileKey = GlobalKey();
    double? previousOffset;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow:  [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 0.5, offset: const Offset(1, 2), blurRadius: 2)
            ]),
        child: ExpansionTile(
          key: expansionTileKey,
          onExpansionChanged: (isExpanded) {
            if (isExpanded) previousOffset = _scrollController.offset;
            _scrollToSelectedContent(
                isExpanded, previousOffset ?? 0.0, index, expansionTileKey);
          },
          title: Text(controller.faqDataList[index].title ?? ''),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.grey.withOpacity(0.1),
          children: _buildExpansionTileChildren(controller,index),
        ),
      ),
    );
  }

  void _scrollToSelectedContent(
      bool isExpanded, double previousOffset, int index, GlobalKey myKey) {
    final keyContext = myKey.currentContext;

    if (keyContext != null) {
      // make sure that your widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      _scrollController.animateTo(
          isExpanded ? (box.size.height * index) : previousOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear);
    }
  }
}
