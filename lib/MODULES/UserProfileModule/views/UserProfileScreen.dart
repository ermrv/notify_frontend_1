import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/UserProfileModule/views/PrimaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/UserProfileModule/views/SecondaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/UserProfileModule/views/PrimaryUserBasicInfoContainer.dart';
import 'package:MediaPlus/MODULES/UserProfileModule/views/SecondaryUserBasicInfoContainer.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///primary user profile
///TODO:5.Edit profile section
///TODO:1.User actions on the post like delete,add to highlights etc
///TODO:4.Grid view of the posts
///TODO:2.Loading comments
///TODO:3.Adding comments
///TODO:6.Shring outside and inside app
class UserProfileScreen extends StatefulWidget {
  final String profileOwnerId;

  const UserProfileScreen({Key key, this.profileOwnerId}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _userIsProfileOwner = false;
  String _thisUserId;
  String _ownerId;

  List data;
  var profileData;

  @override
  void initState() {
    _ownerId = widget.profileOwnerId;
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _userIsProfileOwner = _ownerId == _thisUserId;
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
              _userIsProfileOwner
                  ? PrimaryUserBasicInfoContainer()
                  : profileData == null
                      ? Container(
                        height: 100.0,
                        width: screenWidth,
                          child: Center(
                            child: SpinKitPulse(
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : SecondaryUserBasicInfoContainer(basicUserData: profileData,),
              _userIsProfileOwner
                  ? PrimaryUserActionsOnProfile()
                  : SecondaryUserActionsOnProfile(),
              data == null
                  ? Center(
                      child: SpinKitPulse(
                        color: Colors.blue,
                      ),
                    )
                  : ContentDisplayTemplateProvider(
                      data: data,
                    )
              // PrimaryUserHighlightsContainer(),
            ],
          )),
    );
  }

  _getData() async {
    if (!_userIsProfileOwner) _getBasicProfileData();

    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userPosts, {"_id": widget.profileOwnerId}, userToken);
    if (response != "error") {
      data = response["posts"];
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  ///getting basic user data
  _getBasicProfileData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userProfileBasicData,
        {"profileId": widget.profileOwnerId},
        userToken);
    if (response != "error") {
      profileData = response;
      if (this.mounted) {
        setState(() {});
      }
    }
  }
}
