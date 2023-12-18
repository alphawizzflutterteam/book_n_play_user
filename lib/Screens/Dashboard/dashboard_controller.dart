
import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Models/auth_response_model.dart';
import 'package:booknplay/Screens/Bookings/my_booking_view.dart';
import 'package:booknplay/Screens/Home/home_view.dart';
import 'package:booknplay/Screens/Profile/profile_view.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

String name = '';
String email = '';
String address = '';
String image = '';
String? UserImag;
class DashboardController extends AppBaseController {

User userData = User();

List <Widget>  pages = [
const HomeScreen(),
const MyBookingsScreen(isFrom: false),
const ProfileScreen()
];
@override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    var obj = await SharedPre.getObjs(SharedPre.userData);

    userData = User.fromJson(obj);

    getProfile ();
         getUserCurrentLocation();
  }



RxInt currentIndex = 1.obs ;
int bottomIndex = 0;

String image = '';
String? UserImag;


Future <void> getProfile () async{

  var param = {
    'user_id': userData.id.toString(),
  };

  apiBaseHelper.postAPICall(getProfileApi, param).then((getData) {
    bool error = getData['status'];
    String msg = getData['message'];
    update();
    if (error) {
      //  Fluttertoast.showToast(msg: msg);



      name = getData['data']['first_name'];
      update();
     // mobiile = getData['data']['mobile'];
      email= getData['data']['email'];
      UserImag=getData['data']['profile_photo_path'];
      image=getData['data']['user_image']??"";
      //address= usedata.address ?? '';
      //wallet =  getData['data']['wallet'].toString();
      update();

    } else {
      Fluttertoast.showToast(msg: msg);
    }
  });
}


Position? currentLocation;
String? currentAddress='';
var homelat;
var homeLong;
getUserCurrentLocation() async {
  var status = await Permission.location.request();
  if (status.isDenied) {
  } else if (status == PermissionStatus.granted) {
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((position) {
    update();
          currentLocation = position;
          homelat = currentLocation!.latitude;
          homeLong = currentLocation!.longitude;
          update();
    print("current lat ${homelat}");
    print("current lang ${homeLong}");

    // if(fromInIt){
          //   homelat = currentLocation?.latitude.toString();
          //   homeLong = currentLocation?.longitude.toString();
          //   getDoctors();
          // }

      _getAddressFromLatLng();
      update();
    });
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}

_getAddressFromLatLng() async {
  try {
    print("Addressss function");
    List<Placemark> p = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    Placemark place = p[0];
    update();
    currentAddress =
    "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
    print("current addresssss nowwwww$currentAddress");
    update();

  } catch (e) {
  }
}

}