import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/controllers/OtherUserProfilePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'SecondaryUserActionsOnProfile.dart';
import 'SecondaryUserBasicInfoContainer.dart';

class OtherUserProfilePageScreen extends StatelessWidget {
  final String profileOwnerId;

  OtherUserProfilePageScreen({Key key, @required this.profileOwnerId})
      : super(key: key);

  final controller = Get.put(OtherUserProfilePageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherUserProfilePageController>(
      initState: (state) {
        controller.profileOwnerId = profileOwnerId;
        controller.thisUserId =
            PrimaryUserData.primaryUserData.userId.toString();
        controller.initialise();
      },
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: MediaQuery.removePadding(
          context: context,
          child: ListView(
            controller: controller.scrollController,
            children: [
              controller.profileData == null
                  ? Container()
                  : SecondaryUserBasicInfoContainer(
                      basicUserData: controller.profileData,
                    ),
              controller.profileData == null
                  ? Container()
                  : SecondaryUserActionsOnProfile(
                      profileId: controller.profileOwnerId,
                    ),
              controller.postData == null
                  ? Center(
                      heightFactor: 5.0,
                      child: SpinKitPulse(
                        color: Colors.blue,
                      ),
                    )
                  : controller.postData.length == 0
                      ? Center(
                          child: Text("No post yet!!!"),
                        )
                      : ContentDisplayTemplateProvider(
                          data: controller.postData,
                          controller: controller,
                          useTemplatesAsPostFullDetails: false,
                        ),
              controller.loadingMoreData
                  ? Container(
                      height: 30.0,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.blue,
                      )),
                    )
                  : Container(
                      height: 30.0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
