import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/6_HomePageModule/views/AddPostReferenceView.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/PrimaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/SecondaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/PrimaryUserBasicInfoContainer.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/SecondaryUserBasicInfoContainer.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///primary user profile
class UserProfileScreen extends StatefulWidget {
  final String profileOwnerId;

  const UserProfileScreen({Key key, @required this.profileOwnerId})
      : super(key: key);

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
                      : SecondaryUserBasicInfoContainer(
                          basicUserData: profileData,
                        ),
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
    if (!_userIsProfileOwner) {
      await _getBasicProfileData();
    }

    // var response = await ApiServices.postWithAuth(
    //     ApiUrlsData.userPosts, {"_id": widget.profileOwnerId}, userToken);
    // if (response != "error") {
    //   data = response["posts"];
    //   if (this.mounted) {
    //     setState(() {});
    //   }
    // }
  }

  ///getting basic user data
  _getBasicProfileData() async {
    print(widget.profileOwnerId);
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
