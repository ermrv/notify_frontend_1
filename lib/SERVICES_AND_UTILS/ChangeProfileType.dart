import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class ChangeProfileType extends StatefulWidget {
  @override
  _ChangeProfileTypeState createState() => _ChangeProfileTypeState();
}

class _ChangeProfileTypeState extends State<ChangeProfileType> {
  String currentProfileType;
  String selectedProfileType;

  @override
  void initState() {
    currentProfileType = PrimaryUserData.primaryUserData.profileType.value;
    selectedProfileType = currentProfileType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose account type:"),
      content: Container(
        height: 150.0,
        child: Column(
          children: [
            currentProfileType != "business"
                ? TextButton(
                    onPressed: () {
                      if (this.mounted) {
                        setState(() {
                          selectedProfileType = "private";
                        });
                        print(selectedProfileType);
                      }
                    },
                    child: Container(
                      height: 25.0,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Private Account  "),
                          selectedProfileType == "private"
                              ? Container(
                                  width: 16.0,
                                  height: 16.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Icon(
                                    Icons.done_all,
                                    color: Colors.white,
                                    size: 15.0,
                                  ))
                              : Container()
                        ],
                      ),
                    ))
                : Container(),
            TextButton(
                onPressed: () {
                  if (this.mounted) {
                    setState(() {
                      selectedProfileType = "public";
                    });
                  }
                },
                child: Container(
                  height: 25.0,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Public Account  "),
                      selectedProfileType == "public"
                          ? Container(
                              width: 16.0,
                              height: 16.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Icon(
                                Icons.done_all,
                                color: Colors.white,
                                size: 15.0,
                              ))
                          : Container(),
                    ],
                  ),
                )),
            TextButton(
                onPressed: () {
                  if (this.mounted) {
                    setState(() {
                      selectedProfileType = "business";
                    });
                  }
                },
                child: Container(
                  height: 25.0,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Business Account  "),
                      selectedProfileType == "business"
                          ? Container(
                              width: 16.0,
                              height: 16.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Icon(
                                Icons.done_all,
                                color: Colors.white,
                                size: 15.0,
                              ))
                          : Container(),
                    ],
                  ),
                )),
          ],
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              _updateProfileType();
            },
            child: Text(
              "Done",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  _updateProfileType() async {
    if (currentProfileType == selectedProfileType) {
      Get.back();
    } else {
      Get.back();
      Get.dialog(AlertDialog(
        title: Container(
          child: SpinKitThreeBounce(
            color: Colors.blue,
            size: 18.0,
          ),
        ),
      ));

      var response = await ApiServices.postWithAuth(ApiUrlsData.profileType,
          {"profileType": selectedProfileType}, userToken);
      if (response != "error") {
        Get.back();
        PrimaryUserData.primaryUserData.setProfileType(selectedProfileType);
      } else {
        Get.back();
        Get.dialog(AlertDialog(
          title: Text("Something wrong!!! \n Please try again"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel")),
          ],
        ));
      }
    }
  }
}
