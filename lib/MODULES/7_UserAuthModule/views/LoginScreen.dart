import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/controllers/LoginScreenController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/OTPInputScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginScreen extends StatelessWidget {
  final loginScreenController = Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    screenHeight = Get.size.height;
    screenWidth = Get.size.width;
    return GetBuilder<LoginScreenController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          margin: EdgeInsets.only(
              top: Get.size.height * 0.15, left: 15.0, right: 15.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "media",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 29.0,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5),
                      ),
                      Text(
                        "Plus",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 29.0,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5),
                      ),
                    ],
                  ),
                ),
                //mobile no.
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Enter mobile number:",
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Row(
                        children: [
                          //countary code
                          Card(
                            elevation: 0.5,
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: DropdownButton(
                                underline: Container(),
                                value: controller.selectedCountryCode,
                                elevation: 2,
                                items: controller.countryCode.map((e) {
                                  return DropdownMenuItem(
                                      value: e[1],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(" " + e[0].toString()),
                                          Text(" " + e[1].toString()),
                                        ],
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                  controller
                                      .updateCountryCode(value.toString());
                                },
                              ),
                            ),
                          ),
                          //mobile number
                          Expanded(
                            child: Card(
                              elevation: 0.5,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: TextFormField(
                                  controller: controller.textEditingController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onTap: () {},
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal),
                                  decoration: InputDecoration(
                                      hintText: " Mobile No.",
                                      hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //Get otp button
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: TextButton(
                      child: Container(
                        alignment: Alignment.center,
                        height: 35.0,
                        child: Text(
                          "GET OTP",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () {
                        bool isValid = controller.validateMobileNumber(
                            controller.textEditingController.text);
                        if (isValid) {
                          Get.off(() => OTPInputScreen(), arguments: {
                            "mobile": controller.textEditingController.text,
                            "countryCode":
                                controller.selectedCountryCode.toString()
                          });
                        } else {
                          Get.defaultDialog(
                            radius: 5.0,
                            title: "Invalid Mobile Number",
                            content: Text(
                                "Please enter a valid 10 digit mobile number!"),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                            ],
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
