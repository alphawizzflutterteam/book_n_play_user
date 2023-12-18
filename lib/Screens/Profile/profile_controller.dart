import 'dart:convert';
import 'dart:io';

import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Models/auth_response_model.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class ProfileController extends AppBaseController {


RxBool isLoading = false.obs ;
final loading = true.obs;
String? image;
final picker = ImagePicker();

final phoneC = TextEditingController();
final emailC = TextEditingController();
final addressC = TextEditingController();

bool isEditProfile = false ;
User usedata = User();

String name = '' ;
String wallet = '' ;

File? imageFile;
final formKey = GlobalKey<FormState>();


@override
  void onInit() async{
    // TODO: implement onInit

  var obj = await SharedPre.getObjs(SharedPre.userData);

  usedata = User.fromJson(obj);

   getProfile();
  }


Future getImageFromGallery() async {
  var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50
  );
  imageFile = File(image!.path);
update();
}
Future getImageFromCamera() async {
  var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50
  );
  imageFile = File(image!.path);

  update();

}
String? imagefiledummy;
Future <void> getProfile () async{

  loading.value = true;
print('1');
  var param = {
    'user_id': usedata.id.toString(),
  };
  print('2');

  apiBaseHelper.postAPICall(getProfileApi, param).then((getData) {
    bool error = getData['status'];
    String msg = getData['message'];

    if (error) {
     // Fluttertoast.showToast(msg: msg);
      print('3');
      loading.value = false;
print('${getData['data']['address']}');

      name = getData['data']['first_name'] ?? "";

      phoneC.text = getData['data']['mobile'] ?? "";
      emailC.text = getData['data']['email'] ?? "";
      addressC.text =getData['data']['address'] ?? "";
      wallet =  getData['data']['wallet'].toString();
      imagefiledummy=getData['data']['user_image']??"";
      update();
      print('4');

    } else {
    }

  });
}

Future <void> updateProfile () async{

  isLoading.value = true;

  // var param = {
  //
  //   'user_id': usedata.id.toString(),
  //   'name':usedata.name ?? '',
  //     'email': emailC.text,
  //   'mobile': phoneC.text,
  //   'address': addressC.text,
  //    'image':imageFile.toString()
  //
  //
  // };
  //
  // apiBaseHelper.postAPICall(updateProfileApi, param).then((getData) {
  //   bool error = getData['status'];
  //   String msg = getData['message'];
  //
  //   if (error) {
  //
  //
  //
  //
  //
  //     getProfile();
  //     Fluttertoast.showToast(msg: msg);
  //
  //
  //   } else {
  //     Fluttertoast.showToast(msg: msg);
  //   }
  //   isLoading.value = false;
  // });



  var request = http.MultipartRequest('POST', Uri.parse('https://golf.developmentalphawizz.com/api/update_profile'));
  request.fields.addAll({
    'user_id': usedata.id.toString(),
      'name':usedata.name ?? '',
        'email': emailC.text,
      'mobile': phoneC.text,
      'address': addressC.text,
  });
  if(imageFile!=null) {
    request.files.add(
        await http.MultipartFile.fromPath('image', imageFile!.path));
  }

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
   var result =
await response.stream.bytesToString();
   var finaresult=jsonDecode(result);

   var msg=finaresult['message'];
   bool error=finaresult['status'];
   if(error){

     Fluttertoast.showToast(msg: msg.toString());

   }
  }
  else {
    print(response.reasonPhrase);
  }

  isLoading.value = false;
  update();
}





}