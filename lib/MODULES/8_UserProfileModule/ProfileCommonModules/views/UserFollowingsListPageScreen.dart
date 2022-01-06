import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/ProfileReferenceTemplate.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// stlful widget--Listview which contains all the list of Followings
class UserFollowingsListPageScreen extends StatefulWidget {
  final String userId;

  UserFollowingsListPageScreen({Key key, @required this.userId})
      : super(key: key);

  @override
  State<UserFollowingsListPageScreen> createState() =>
      _UserFollowingsListPageScreenState();
}

class _UserFollowingsListPageScreenState
    extends State<UserFollowingsListPageScreen> {
  String profileId;
  List data;
  bool requestProcessed = false;

  @override
  void initState() {
    super.initState();
    profileId = widget.userId;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Text(
          "Followings",
        ),
      ),
      body: requestProcessed
          ? data.length == 0
              ? Center(
                  heightFactor: 5.0,
                  child: Text("No Followings!"),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ProfileReferenceTemplate(
                        showVerticalTemplate: false, userData: data[index]);
                  },
                )
          : Center(
              child: SpinKitThreeBounce(
                size: 22.0,
                color: Colors.blue,
              ),
            ),
    );
  }

  getData() async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.userFollowings,
        {"userId": profileId}, userToken.toString());
    if (response == "error") {
      print("some error occured");
    } else {
      if (this.mounted) {
        setState(() {
          requestProcessed = true;
          data = response;
        });
      }
    }
  }
}
