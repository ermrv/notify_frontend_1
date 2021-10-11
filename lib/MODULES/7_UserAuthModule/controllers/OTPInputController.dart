import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/GetUserData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/SignupScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_mac/get_mac.dart';

class OTPInputController extends GetxController {
  final String mobileNumber;
  final String countryCode;
  bool isVerifying = false;

  OTPInputController(this.mobileNumber, this.countryCode);
  String otp;

  var data;
  var otpVerificationResponse;
  @override
  onInit() {
    print(mobileNumber);
    super.onInit();
    _getData();
  }

  _getData() async {
    var response = await ApiServices.post(
        ApiUrlsData.mobileOtp, {"mobile": mobileNumber.toString()});
    if (response == "error") {
      print("error");
    } else {
      data = response;
      update();
    }
  }

  verifyOtp(String otp) async {
    isVerifying = true;
    update();
    var response = await ApiServices.post(
        ApiUrlsData.verifyOtp, {"mobile": data["mobile"], "code": otp});
    if (response == "error") {
      print("error");
      isVerifying = false;
      update();
    } else {
      otpVerificationResponse = response;
      _navigator();
    }
  }

  _navigator() {
    print(otpVerificationResponse);
    if (otpVerificationResponse != "error") {
      if (otpVerificationResponse["otpVerified"].toString() == "true") {
        final storage = GetStorage();

        if (otpVerificationResponse["registered"].toString() == "true") {
          storage.write("userToken", otpVerificationResponse["token"]);
          userToken = otpVerificationResponse["token"];
          _sendMacAddress();
          Get.offAll(() => GetUserData());
        } else if (otpVerificationResponse["registered"].toString() ==
            "false") {
          print("not registered");
          storage.write(
              "unRegisteredUserToken", otpVerificationResponse["token"]);
          unregisteredUserToken = otpVerificationResponse["token"];
          Get.off(SignupScreen());
        }
      } else {
        print("token error");
      }
    } else {
      print("error");
    }
  }

  _sendMacAddress() async {
    // String macAddress;
    // try {
    //   macAddress = await GetMac.macAddress;
    //   var response = await ApiServices.postWithAuth(
    //       ApiUrlsData.userLoginActivity, {"macAdress": macAddress}, userToken);
    // } catch (e) {
    //   print(e);
    // }
  }
}
