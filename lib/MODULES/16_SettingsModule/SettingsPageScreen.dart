import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SettingsPageScreen extends StatefulWidget {
  @override
  _SettingsPageScreenState createState() => _SettingsPageScreenState();
}

class _SettingsPageScreenState extends State<SettingsPageScreen> {
  var settingsData;
  bool securityNotifications = true;
  bool mentioningNotification = true;
  bool commentNotification = true;
  bool likeNotification = true;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();

    _getSettingsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      bottomSheet:settingsData == null?Container(height: 1.0,): Container(
        height: 40.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: TextButton(
            onPressed: () {
              _updateSettingsData();
            },
            child: Container(
                height: 40.0,
                alignment: Alignment.center,
                child: isUpdating
                    ? SpinKitThreeBounce(
                        color: Colors.blue,
                        size: 18.0,
                      )
                    : Text("Update Settings"))),
      ),
      body: settingsData == null
          ? Center(
          child: SpinKitThreeBounce(
            color: Colors.blue,
            size: 18.0,
          ),
            )
          : ListView(
              children: [
                Container(
                  child: Text(
                    " Notifications Settings",
                    style: TextStyle(fontSize: 21.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Security Notiications",
                          style: TextStyle(fontSize: 16.0)),
                      Switch(
                          value: securityNotifications,
                          onChanged: (value) {
                            setState(() {
                              securityNotifications = value;
                            });
                          })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mentioning Notiications",
                          style: TextStyle(fontSize: 16.0)),
                      Switch(
                          value: mentioningNotification,
                          onChanged: (value) {
                            setState(() {
                              mentioningNotification = value;
                            });
                          })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Comment Notiications",
                          style: TextStyle(fontSize: 16.0)),
                      Switch(
                          value: commentNotification,
                          onChanged: (value) {
                            setState(() {
                              commentNotification = value;
                            });
                          })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Like Notiications",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Switch(
                          value: likeNotification,
                          onChanged: (value) {
                            setState(() {
                              likeNotification = value;
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
    );
  }

  _getSettingsData() async {
    var response =
        await ApiServices.postWithAuth(ApiUrlsData.userSettings, {}, userToken);
    if (response != "error") {
      if (this.mounted) {
        setState(() {
          settingsData = response;
          mentioningNotification = response["mentioningNotifications"];
          securityNotifications = response["securityNotifications"];
          commentNotification = response["commentNotifications"];
          likeNotification = response["likeNotifications"];
        });
      }
    } else {
      Get.snackbar("Cannot update now", "Some error occured");
      setState(() {
        isUpdating = false;
      });
    }
  }

  _updateSettingsData() async {
    setState(() {
      isUpdating = true;
    });
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.updateUserSettings,
        {
          "mentioningNotifications": mentioningNotification,
          "likeNotifications": likeNotification,
          "commentNotifications": commentNotification,
          "securityNotifications": securityNotifications
        },
        userToken);

    if (response != "error") {
      Get.back();
    } else {
      Get.snackbar("Cannot update now", "Some error occured");
      setState(() {
        isUpdating = false;
      });
    }
  }
}
