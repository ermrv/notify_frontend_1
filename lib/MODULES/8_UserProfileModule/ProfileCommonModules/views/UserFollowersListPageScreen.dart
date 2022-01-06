import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/ProfileReferenceTemplate.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


/// stlful widget--Listview which contains all the list of Followings
class UserFollowersListPageScreen extends StatefulWidget {
  final String userId;

  UserFollowersListPageScreen({Key key, @required this.userId})
      : super(key: key);

  @override
  State<UserFollowersListPageScreen> createState() =>
      _UserFollowersListPageScreenState();
}

class _UserFollowersListPageScreenState
    extends State<UserFollowersListPageScreen> {
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
          "Followers",
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
                        showVerticalTemplate: false,
                        userData: data[index]);
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

  //get data
  getData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userFollowers, {"userId": profileId}, userToken.toString());
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
