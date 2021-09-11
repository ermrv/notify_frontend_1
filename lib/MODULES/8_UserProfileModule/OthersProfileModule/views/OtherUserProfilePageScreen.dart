import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'SecondaryUserActionsOnProfile.dart';
import 'SecondaryUserBasicInfoContainer.dart';

class OtherUserProfilePageScreen extends StatefulWidget {
  final String profileOwnerId;

  const OtherUserProfilePageScreen({Key key, @required this.profileOwnerId})
      : super(key: key);
  @override
  _OtherUserProfilePageScreenState createState() =>
      _OtherUserProfilePageScreenState();
}

class _OtherUserProfilePageScreenState
    extends State<OtherUserProfilePageScreen> {
  String _thisUserId;
  String _profileOwnerId;

  List postData;
  var profileData;

  @override
  void initState() {
    _profileOwnerId = widget.profileOwnerId;
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: MediaQuery.removePadding(
          context: context,
          child: ListView(
            children: [
              profileData == null
                  ? Container()
                  : SecondaryUserBasicInfoContainer(
                      basicUserData: profileData,
                    ),
              profileData == null
                  ? Container()
                  : SecondaryUserActionsOnProfile(
                      profileId: _profileOwnerId,
                    ),

              postData == null
                  ? Center(
                      child: SpinKitPulse(
                        color: Colors.blue,
                      ),
                    )
                  : postData.length == 0
                      ? Center(
                          child: Text("No post yet!!!"),
                        )
                      : ContentDisplayTemplateProvider(
                          data: postData,
                        )
              // PrimaryUserHighlightsContainer(),
            ],
          )),
    );
  }

  _getData() async {
    await _getBasicProfileData();

    var response = await ApiServices.postWithAuth(
        ApiUrlsData.otherUserPosts, {"userId": _profileOwnerId}, userToken);
    if (response != "error") {
      postData = response;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  ///getting basic user data
  _getBasicProfileData() async {
    print(widget.profileOwnerId);
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.otherUserProfileBasicData,
        {"userId": _profileOwnerId},
        userToken);
    if (response != "error") {
      profileData = response;
      if (this.mounted) {
        setState(() {});
      }
    }
  }
}
