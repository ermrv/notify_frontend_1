import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/controllers/OwnProfilePageScreenController.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/PrimaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/PrimaryUserBasicInfoContainer.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/DataLoadingShimmerAnimations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///for displaying user own profiile data
///uses the [ContentDisplayTemplateProvider] for displaying posts
class OwnProfilePageScreen extends StatelessWidget {
  final _controller = Get.put(OwnProfilePageScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnProfilePageScreenController>(
      builder: (controller) => Scaffold(
        body: ListView(
          key: PageStorageKey("ownProfilePageScreen"),
          controller: controller.scrollController,
          children: [
            PrimaryUserBasicInfoContainer(),

            PrimaryUserActionsOnProfile(),

            controller.profilePostData == null
                ? DataLoadingShimmerAnimations(animationType: "postOnlyColumn")
                : controller.profilePostData.length == 0
                    ? Center(
                        child: Text("No posts yet!!!"),
                      )
                    : ContentDisplayTemplateProvider(
                        data: controller.profilePostData,
                        controller: controller,
                        useTemplatesAsPostFullDetails: false,
                      ),
                      controller.loadingMoreData
                            ? Container(
                                height: 40.0,
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
    );
  }
}
