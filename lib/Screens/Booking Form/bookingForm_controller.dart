import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Local_Storage/shared_pre.dart';
import '../../../Models/auth_response_model.dart';
import '../../../Models/bookingModel/bookingDetailsModel.dart';
import '../../../Services/api_services/apiStrings.dart';
import '../../Models/Apply Promocode/apply_promocode_model.dart';
import '../../Models/HomeModel/groundDetailsModel.dart';
import '../../Models/Time Slot Model/timeSlotModel.dart';

class BookingFormController extends AppBaseController{


  User usedata = User();
  String?graoundId;
  String ?msg;
  int ?totalAmount;
  var selectTimeFrom;
  var selectTimeTo;
  int ?tabIndex=0;
  var checkTime;


  int?finalAmount;
  List<Slot> timeSlot2=[];
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    var obj = await SharedPre.getObjs(SharedPre.userData);

    usedata = User.fromJson(obj);

    totalAmount=Get.arguments['totlaPrice'];
    print('groud price========${totalAmount}');

    graoundId=Get.arguments['groundId'];
    print('groundId========${graoundId}');

    finalAmount=totalAmount;
    print('final amount without promo========${finalAmount}');

    namecontroller.text = usedata.name ?? '' ;
    emailcontroller.text = usedata.email ?? '' ;
    mobilcontroller.text = usedata.mobile ?? '' ;
    addresscontroller.text = usedata.address ?? '' ;

    update();
  }
  DateTime selectedDate = DateTime.now();
  Future<void> sselectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)

        selectedDate = picked;
        datecontroller.text=
            DateFormat('yyyy-MM-dd').format(selectedDate);
        print("==================${datecontroller.text}");
    availableSlot();


 update();
  }

  final formKey = GlobalKey<FormState>();
  TimeslotModel?timeslotModel;
  Future<void> availableSlot() async{
    print('get details');
    var param = {

      "ground_id":graoundId.toString(),
      "date":datecontroller.text

    };
    apiBaseHelper.postAPICall(AvailableTimeSlot, param).then((getData) {
      bool error = getData['status'];
      msg = getData['message'];
      update();
      if (error) {
var finalresult=TimeslotModel.fromJson(getData);
timeslotModel=finalresult;
timeSlot2=timeslotModel!.data.slots;
        update();
        Fluttertoast.showToast(msg: msg.toString());

      } else {
        Fluttertoast.showToast(msg: msg.toString());

      }
    });

  }

  String ?msg1;
  Future<void> BookGround() async{
    var param = {

      'user_id': usedata.id.toString(),
      'ground_id': graoundId.toString(),
      'booking_date': datecontroller.text,
      'booking_time_from': selectTimeFrom.toString(),
      'booking_time_to': selectTimeTo.toString(),
      'total_amount': finalAmount.toString(),
      'booking_name': namecontroller.text.toString(),
      "booking_email":emailcontroller.text.toString(),
      "booking_mobile":mobilcontroller.text.toString(),
    };
    apiBaseHelper.postAPICall(BookingGround, param).then((getData) {
      print(getData);
      bool error = getData['status'];
      msg = getData['message'];
      update();
      if (error) {

        Fluttertoast.showToast(msg: msg.toString());
        Get.offAllNamed(bottomBar);
        update();

      } else {
        update();
      }
    });

  }
  ApplypromoModel?applypromoModel;
  Future<void> Applypromo() async{
    var param = {
      'code': promocodeController.text.toString(),
      'total_amount': totalAmount.toString()
    };
    apiBaseHelper.postAPICall(ApplyPromocode, param).then((getData) {
      print(getData);
      bool error = getData['status'];
      msg = getData['message'];
      update();
      if (error) {

        var finalresult=ApplypromoModel.fromJson(getData);
applypromoModel=finalresult;
finalAmount=applypromoModel?.data.payAmount;
        print('final amount with promo========${finalAmount}');

update();
        Fluttertoast.showToast(msg: msg.toString());

        update();

      } else {
        update();
      }
    });

  }





  TextEditingController promocodeController=TextEditingController();
  TextEditingController datecontroller=TextEditingController();
  TextEditingController timecontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController mobilcontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();

}

