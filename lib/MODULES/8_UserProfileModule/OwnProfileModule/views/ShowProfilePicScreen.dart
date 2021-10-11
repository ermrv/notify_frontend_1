import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/controllers/ShowProfilePicController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ShowProfilePicScreen extends StatelessWidget {
  final showProfilePicController = Get.put(ShowProfilePicController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowProfilePicController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile Pic",
            style: TextStyle(color: Colors.black),
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
        ),
        body: MediaQuery.removePadding(
          context: context,
          child: Column(
            children: [
              Container(
                  child: Stack(
                children: [
                  AspectRatio(
                      aspectRatio: 1,
                      child: controller.profilePicFile == null
                          ? Obx(
                              () => CachedNetworkImage(
                                imageUrl: PrimaryUserData
                                    .primaryUserData.profilePic.value,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.file(
                              controller.profilePicFile,
                              fit: BoxFit.cover,
                            )),
                  Positioned(
                      bottom: 5.0,
                      right: 5.0,
                      child: TextButton(
                        child: Text("Change"),
                        onPressed: () {
                          controller.getProfilePicFile();
                        },
                      ))
                ],
              )),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: TextButton(
                    child: Container(
                      height: 45.0,
                      alignment: Alignment.center,
                      child: controller.isUpdating
                          ? SpinKitThreeBounce(
                              color: Colors.blue,
                              size: 18.0,
                            )
                          : Text("Done"),
                    ),
                    onPressed: () {
                      controller.updateProfilePic();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
