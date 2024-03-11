import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../Local_Storage/shared_pre.dart';
import '../../../Models/auth_response_model.dart';
import '../../../Models/bookingModel/bookingDetailsModel.dart';
import '../../../Services/api_services/apiStrings.dart';

class BookingDetailsController extends AppBaseController {
  User usedata = User();
  String? bookingId;
  String? groundId;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    bookingId = Get.arguments["bookingId"].toString();
    groundId = Get.arguments["GroundId"].toString();
    var obj = await SharedPre.getObjs(SharedPre.userData);

    usedata = User.fromJson(obj);

    getBookingDetails();
  }

  DateTime? checkdate;
  String hint = '';
  final CarouselController carouselController = CarouselController();

  // int currentIndex =0;
  final currentIndex = 0.obs;
  BookingDetailsModel? bookingDetailsModel;
  String? msg;

  int extractHour(String timeString) {
    // Assuming timeString is in the format "H:mm"
    List<String> parts = timeString.split(':');
    if (parts.length == 2) {
      int hour = int.tryParse(parts[0]) ?? 0;
      return hour;
    } else {
      return 0; // Handle invalid format
    }
  }

  int countDigits(int number) {
    // Convert the number to a string and check its length
    String numberString = number.toString();
    return numberString.length;
  }

  Future<void> getBookingDetails() async {
    var param = {
      'user_id': usedata.id.toString(),
      // 'user_id': '120',

      "booking_id": bookingId.toString()
    };
    print("----------->${param}");
    apiBaseHelper.postAPICall(GetBookingDetails, param).then((getData) {
      print("--ffffffffffffff----${GetBookingDetails}----->${getData}");
      print(getData);
      bool error = getData['status'];
      msg = getData['message'];
      update();
      if (error) {
        var finalresult = BookingDetailsModel.fromJson(getData);

        var gettime = bookingDetailsModel = finalresult;
        update();
        var timeee = bookingDetailsModel?.data.bookingTo.toString();
        update();
        int hour = extractHour(timeee!);

        print("Hour: $hour");

        int numberOfDigits = countDigits(hour);
        var CheckTime;
        if (numberOfDigits == 1) {
          CheckTime =
              "${bookingDetailsModel?.data.bookingDate} ${bookingDetailsModel?.data.bookingTo}:00.000";
          update();
        } else {
          CheckTime =
              "${bookingDetailsModel?.data.bookingDate} ${bookingDetailsModel?.data.bookingTo}:00.000";
          update();
        }

        checkdate = DateTime.parse(CheckTime);

        print(
            "=========datetimeindex===========${checkdate}===========now ===${DateTime.now()}");
        print(
            "=========datetimeindex===========${DateTime.now()}===========now ===}");
        // DateTime dateTimechek =
        // DateTime.parse("2023-11-20 00:00:00.000");
      } else {
        // Fluttertoast.showToast(msg: msg.toString());
      }
    });
  }

  bool canclebooking = false;
  var msg1;

  Future<void> canclerequest() async {
    var param = {
      'user_id': usedata.id.toString(),
      "booking_id": bookingId.toString(),
      "cancel_reason": Resoncontroller.text
    };
    print("----------->${param}");
    apiBaseHelper.postAPICall(cancleBooking, param).then((getData) {
      bool error = getData['status'];
      msg1 = getData['message'];
      update();
      if (error) {
        Fluttertoast.showToast(msg: msg1);
        canclebooking = false;
        update();
        Get.back();
      } else {
        canclebooking = false;
        Fluttertoast.showToast(msg: msg1.toString());
      }
    });
  }


  Future<void> raiseComplaint() async {
    var param = {
      'user_id': usedata.id.toString(),
      "booking_id": bookingId.toString(),
      "cancel_reason": Resoncontroller.text
    };
    apiBaseHelper.postAPICall(raiseComplaintRequest, param).then((getData) {
      bool error = getData['status'];
      msg1 = getData['message'];
      update();
      if (error) {
        Fluttertoast.showToast(msg: msg1);
        canclebooking = false;
        update();
        Get.back();
      } else {
        canclebooking = false;
        update();
        Fluttertoast.showToast(msg: msg1.toString());
      }
    });
  }


  TextEditingController Resoncontroller = TextEditingController();

  showAlertDialog(BuildContext context) {
    Widget okButton = OutlinedButton(
      child: const Text(
        "Yes",
        style: TextStyle(color: AppColors.primary),
      ),
      onPressed: () {
        hint = 'Enter Reason For Cancel Booking';
        canclebooking = true;
        update();
        Get.back();
      },
    );

    Widget okButton2 = OutlinedButton(
      child: Text(
        "No",
        style: TextStyle(color: AppColors.primary),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the button

    AlertDialog alert = AlertDialog(
      title: const Text("Are You Sure?"),
      content: const Text("You Want To Cancel Booking"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            okButton,
            okButton2,
          ],
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onTabRaiseComplaint() {
    hint = 'Enter your complaint';
    canclebooking = true;
    update();
  }

  final formKey = GlobalKey<FormState>();
}
