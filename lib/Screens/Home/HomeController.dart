import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Models/HomeModel/ground_reponse.dart';
import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/home_cat_reponce.dart';
import '../../Models/HomeModel/home_slider_reponse.dart';
import '../../Models/auth_response_model.dart';
import '../../Services/api_services/apiStrings.dart';
import '../Dashboard/dashboard_controller.dart';

class HomeController extends AppBaseController {
  final CarouselController carouselController = CarouselController();
  List<HomeCatList> catList = [];
  List<GroundList> groundList = [];
  List<GroundList> tempList = [];
  RxBool isGroundLoading = false.obs;

  RxBool isCatLoading = false.obs;

  String? onChangeResult;

  bool isFilterApplied = false;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    homeSlider();
    homeCategory();
    homeGround('');
    getProfile();
    // TODO: implement initState
  }

  Future<void> getProfile() async {
    User userData = User();
    var obj = await SharedPre.getObjs(SharedPre.userData);

    userData = User.fromJson(obj);
    update();
    var param = {
      'user_id': userData.id.toString(),
    };

    apiBaseHelper.postAPICall(getProfileApi, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];
      update();
      if (error) {
        //  Fluttertoast.showToast(msg: msg);

        update();

        name = getData['data']['first_name'];
        update();
        // mobiile = getData['data']['mobile'];
        email = getData['data']['email'];
        UserImag = getData['data']['profile_photo_path'];
        image = getData['data']['user_image'] ?? "";
        //address= usedata.address ?? '';
        //wallet =  getData['data']['wallet'].toString();
        update();
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

  RxInt currentIndex = 0.obs;

  RxInt catCurrentIndex = (-1).obs;

  List<SliderDataList> sliderList = [];

  Future<void> homeSlider() async {
    apiBaseHelper.getAPICall(homeSliderAPI).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];
      if (error) {
        sliderList = (getData['data'] as List)
            .map((e) => SliderDataList.fromJson(e))
            .toList();
      } else {}
    });
  }

  Future<void> homeCategory() async {
    isCatLoading.value = true;
    apiBaseHelper.getAPICall(homeCategoryAPI).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];
      if (error) {
        catList = (getData['data'] as List)
            .map((e) => HomeCatList.fromJson(e))
            .toList();
      } else {
        update();
      }
      isCatLoading.value = false;
    });
  }

  searchLeads(String value) {
    if (value.isEmpty) {
      homeGround("");
      update();
    } else {
      final suggestions = groundList.where((element) {
        final defautPrice = element.defaultPrice.toString().toLowerCase();
        final leadsTitle = element.title.toString().toLowerCase();
        final leadsPhone = element.address.toString().toLowerCase();
        final leadCategory = element.categoryTitle.toString().toLowerCase();
        final leadFacility = element.facility.toString().toLowerCase();
        // final leadsId = element.agreementid.toString().toLowerCase();
        final input = value.toLowerCase();
        return leadsTitle.contains(input) ||
                leadsPhone.contains(input) ||
                leadFacility.contains(input) ||
                leadCategory.contains(input) ||
                defautPrice.contains(input)
            // || leadsId.contains(input)
            ;
      }).toList();
      groundList = suggestions;
      update();
    }
  }

  void handleOnChangedResult(String? result) {
    onChangeResult = result;
    if (result != null) {
      groundList.clear();
      for (var v in tempList) {
        print(v.title!.toLowerCase());
        if (v.title!.toLowerCase().contains(result.toLowerCase())) {
          groundList.add(v);
        }
      }
      update();
    } else {
      groundList = tempList.toList();
      update();
    }
  }

  Future<void> homeGround(String catId) async {
    isGroundLoading.value = true;
    isFilterApplied = false;
    datecontroller.clear();
    timeController.clear();
    timeslotSectcat = null;
    selectCatIddd = null;
    apiBaseHelper
        .getAPICall(Uri.parse('${baseUrl}all_ground?category=$catId'))
        .then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];
      if (error) {
        groundList = (getData['data'] as List)
            .map((e) => GroundList.fromJson(e))
            .toList();
        isGroundLoading.value = false;
        tempList = groundList.toList();
        update();
      } else {
        isGroundLoading.value = false;
        update();
      }
    });
  }

  void selectedCategory(int index) {
    catCurrentIndex.value = index;
    catList.forEach((element) {
      element.isSelected = false;
    });
    catList[index].isSelected = true;
    homeGround(catList[index].id.toString() ?? '');
  }

  Future<void> searchbytimeslot() async {
    isFilterApplied = true ;
    var param = {
      'category_id': "${timeslotSectcat.toString()}",
      'date': "${datecontroller.text.toString()}",
      'time': '${timeController.text.toString()}:00'
    };

    apiBaseHelper.postAPICall(SearchbytimeSlotAPI, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];
      if (error) {
        groundList = (getData['data'] as List)
            .map((e) => GroundList.fromJson(e))
            .toList();
        datecontroller.clear();
        timeController.clear();
        update();
        Get.back();
      } else {
        Get.back();
        Fluttertoast.showToast(msg: msg.toString());
        groundList.clear();
        update();
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  int? timeslotSectcat;
  int? selectCatIddd;

  TextEditingController datecontroller = TextEditingController();
  TextEditingController timeController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> sselectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) selectedDate = picked;
    datecontroller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    print("==================${datecontroller.text}");

    update();
  }
}
