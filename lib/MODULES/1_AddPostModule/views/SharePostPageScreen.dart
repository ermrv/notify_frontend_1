import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/SharePostPageController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharePostPageScreen extends StatelessWidget {
  final postId;
  final String postOwnerName;
  final String postOwnerProfilePic;

  SharePostPageScreen(
      {Key key,
      @required this.postId,
      @required this.postOwnerName,
      @required this.postOwnerProfilePic})
      : super(key: key);

  final _controller = Get.put(SharePostPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SharePostPageController>(
      initState: (state) {
        _controller.postId = postId;
        _controller.initialise();
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Share a post"),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  if (!controller.isUploading) {
                    controller.uploadPost();
                  }
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
                    child: controller.isUploading
                        ? Text("Uploading")
                        : Text(" Post ")),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: CachedNetworkImage(
                          imageUrl: PrimaryUserData.primaryUserData.profilePic,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              PrimaryUserData.primaryUserData.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16.0,
                                ),
                                Text(" "),
                                Container(
                                  child: controller.location == null
                                      ? Text("Select Location")
                                      : Text(controller.location.toString()),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                width: screenWidth,
                child: TextFormField(
                  controller: controller.textEditingController,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(fontSize: 16.0),
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "Wanna say something...?",
                      hintStyle: TextStyle(fontSize: 16.0)),
                ),
              ),
              Container(
                height: 15.0,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5,
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: CachedNetworkImage(
                        imageUrl: ApiUrlsData.domain + postOwnerProfilePic,
                      ),
                    ),
                    Text(
                      postOwnerName + "'s post",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
