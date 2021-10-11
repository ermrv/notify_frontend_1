import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/controllers/OwnProfilePageScreenController.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/PrimaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/PrimaryUserBasicInfoContainer.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

///for displaying user own profiile data
///uses the [ContentDisplayTemplateProvider] for displaying posts
class OwnProfilePageScreen extends StatelessWidget {
  final _controller = Get.put(OwnProfilePageScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnProfilePageScreenController>(
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
              key: PageStorageKey("ownProfilePageScreen"),
              controller: controller.scrollController,
              children: [
                PrimaryUserBasicInfoContainer(),

                PrimaryUserActionsOnProfile(),

                controller.profilePostData == null
                    ? Center(
                        child: SpinKitPulse(
                          color: Colors.blue,
                        ),
                      )
                    : controller.profilePostData.length == 0
                        ? Center(
                            child: Text("No posts yet!!!"),
                          )
                        : ContentDisplayTemplateProvider(
                            data: controller.profilePostData,
                            controller: controller,
                          )
              ],
            )),
      ),
    );
  }
}
