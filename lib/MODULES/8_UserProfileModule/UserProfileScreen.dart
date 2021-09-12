
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/OtherUserProfilePageScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/SecondaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/SecondaryUserBasicInfoContainer.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/OwnProfilePageScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/PrimaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/PrimaryUserBasicInfoContainer.dart';

import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///this widget checks if the profile is owned by the user or
///the profile is owner by other user
///
///accordingly the body is selected as [OwnProfilePageScreen] or [OtherUserProfilePageScreen]
class UserProfileScreen extends StatelessWidget {
  final String profileOwnerId;

  const UserProfileScreen({Key key, @required this.profileOwnerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: profileOwnerId == PrimaryUserData.primaryUserData.userId
          ? OwnProfilePageScreen()
          : OtherUserProfilePageScreen(
              profileOwnerId: profileOwnerId,
            ),
    );
  }
}
