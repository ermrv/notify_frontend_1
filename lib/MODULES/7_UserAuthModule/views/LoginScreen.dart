import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/controllers/LoginScreenController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/OTPInputScreen.dart';
import 'package:flutter/material.dart';
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
              top: Get.size.height * 0.25, left: 15.0, right: 15.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Media",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 29.0,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5),
                      ),
                      Text(
                        "Plus",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 29.0,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5),
                      ),
                    ],
                  ),
                ),
                //mobile no.
                Container(
                  child: Row(
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
                              controller.updateCountryCode(value.toString());
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
                              onTap: () {},
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.0)),
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
                ),
                //Get otp button
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 0.5,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45.0,
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
                  margin: EdgeInsets.only(top: 8.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Login Using Password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 45.0),
                  child: Column(
                    children: [
                      Text(
                        "-------------OR------------",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "One Click Register with:    ",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                            ),
                            Expanded(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  elevation: 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "TrueCaller",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Icon(Icons.phone, color: Colors.blue)
                                    ],
                                  ),
                                  onPressed: () {}),
                            )
                          ],
                        ),
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
