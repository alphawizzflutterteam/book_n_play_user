import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import '../../../Local_Storage/shared_pre.dart';
import '../../../Models/auth_response_model.dart';
import '../../../Models/bookingModel/bookingDetailsModel.dart';
import '../../../Services/api_services/apiStrings.dart';
import '../../Models/HomeModel/groundDetailsModel.dart';

class PopulerGroundDetailsController extends AppBaseController {
  String groundId = "";

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    groundId = Get.arguments.toString();

    getGroundDetails();
  }

  List<String> isoffer = [];
  final CarouselController carouselController = CarouselController();
  final currentIndex = 0.obs;

  GroundDetailsModel? groundDetailsModel;
  final loading = false.obs;
  String? msg;

  Future<void> getGroundDetails() async {
    loading.value = true;
    var param = {
      'id': groundId.toString(),
    };
    apiBaseHelper.postAPICall(GetGroundDetails, param).then((getData) {
      print(getData);
      bool error = getData['status'];
      msg = getData['message'];

      loading.value = false;
      if (error) {
        var finalresult = GroundDetailsModel.fromJson(getData);

        groundDetailsModel = finalresult;

        for (int i = 0; i < groundDetailsModel!.data.timeSlotes.length; i++) {
          if (groundDetailsModel?.data.timeSlotes[i].isOffer == 1) {
            isoffer
                .add(groundDetailsModel!.data.timeSlotes[i].isOffer.toString());
          }
        }

        update();
      } else {
        // Fluttertoast.showToast(msg: msg.toString());
      }
    });
  }
}
