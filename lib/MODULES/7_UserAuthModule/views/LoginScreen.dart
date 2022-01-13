import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/PrivacyPolicyPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/TermsAndConditionsPageScreen.dart';
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "notify",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 29.0,
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
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Enter Mobile Number to Login/SignUp:",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Row(
                        children: [
                          //countary code
                          Container(
                            height: 70.0,
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
                                controller.updateCountryCode(value.toString());
                              },
                            ),
                          ),
                          //mobile number
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5.0),
                              height: 50.0,
                              child: TextFormField(
                                maxLength: 10,
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //Get otp button
                Container(
                  margin: EdgeInsets.only(top: 30.0),
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
                Container(
                  child: Wrap(
                    children: [
                      Text("By signing in, you agree to our "),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => TermsAndConditionsPageScreen());
                        },
                        child: Text(
                          "Terms and Conditions ",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      Text("and "),
                      GestureDetector(
                        onTap: () {
                          Get.to(PrivacyPolicyPageScreen());
                        },
                        child: Text("Privacy Policy.",
                            style: TextStyle(color: Colors.blue)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
