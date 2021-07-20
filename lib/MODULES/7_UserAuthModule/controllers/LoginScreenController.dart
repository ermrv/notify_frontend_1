import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginScreenController extends GetxController {
  TextEditingController textEditingController;
  String mobileNumber;

  ///options of country code
  List countryCode = [
    ["IND", "+91"],
    ["USA", "+90"]
  ];
  String selectedCountryCode = "+91";

  @override
  void onInit() {
    textEditingController = TextEditingController();
    if (mobileNumber != null) {
      textEditingController.text = mobileNumber;
    }
    super.onInit();
  }

  ///country code update
  updateCountryCode(String countryCode) {
    selectedCountryCode = countryCode;
    update();
  }

  ///mobile number input validator
  bool validateMobileNumber(String mobileNumber) {
    bool status;
    if (mobileNumber.length == 10) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }
}
