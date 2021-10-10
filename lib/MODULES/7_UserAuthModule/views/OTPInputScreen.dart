import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/controllers/OTPInputController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPInputScreen extends StatelessWidget {
  final otpInputController = Get.put(OTPInputController(
      Get.arguments["mobile"], Get.arguments["countryCode"]));
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPInputController>(
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              body: controller.data == null
                  ? Center(
                      child: SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 25.0,
                    ))
                  : Center(
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              height: screenHeight,
                              width: screenWidth,
                            ),
                            Positioned(
                                top: screenHeight * 0.15,
                                child: Column(
                                  children: [
                                    Container(
                                      width: screenWidth * 0.9,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Enter OTP sent to:",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15.0),
                                      width: screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              controller.countryCode +
                                                  controller.mobileNumber,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600)),
                                          RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              elevation: 0,
                                              child: Text(
                                                "CHANGE",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Get.off(LoginScreen(),
                                                    arguments: controller
                                                        .mobileNumber
                                                        .toString());
                                              })
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth,
                                      alignment: Alignment.center,
                                      child: OTPTextField(
                                        length: 6,
                                        width: screenWidth * 0.9,
                                        fieldWidth: screenWidth * 0.1,
                                        textFieldAlignment:
                                            MainAxisAlignment.spaceAround,
                                        fieldStyle: FieldStyle.box,
                                        onChanged: (value) {
                                          controller.otp = value;
                                        },
                                        onCompleted: (value) {
                                          controller.verifyOtp(value);
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 25.0),
                                      child: TextButton(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: screenWidth * 0.8,
                                            height: 35.0,
                                            child: controller.isVerifying
                                                ? SpinKitThreeBounce(
                                                    color: Colors.blue,
                                                    size: 18.0,
                                                  )
                                                : Text(
                                                    "VERIFY OTP",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          ),
                                          onPressed: () {
                                            if (!controller.isVerifying) {
                                              if (controller.otp != null &&
                                                  controller.otp.length == 6) {
                                                controller
                                                    .verifyOtp(controller.otp);
                                              } else {
                                                Get.snackbar("Invalid Otp",
                                                    "Invalid Otp");
                                              }
                                            }else{

                                            }
                                          }),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
            ));
  }
}
