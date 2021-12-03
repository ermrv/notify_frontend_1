import 'package:MediaPlus/MODULES/1_AddPostModule/views/EditPostPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/controllers/ContentDisplayTemplateManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class PostOwnerActionsOnPost extends StatelessWidget {
  final String postId;
  final String postDescription;
  final Function(String) editedDescriptionUpdater;
  final parentController;
  final Function removePost;

  const PostOwnerActionsOnPost(
      {Key key,
      @required this.postId,
      @required this.postDescription,
      @required this.editedDescriptionUpdater,
      @required this.parentController,
      @required this.removePost})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          onPressed: () {
            Get.bottomSheet(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () async {
                        Get.back();
                        String description =
                            await Get.to(() => EditPostPageScreen(
                                  description: postDescription,
                                  postId: postId,
                                ));

                        editedDescriptionUpdater.call(description);
                      },
                      child: Text('Edit Post'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        Get.dialog(AlertDialog(
                          title: Text("Post will be deleted permanently"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () async {
                                  Get.back();

                                  Get.dialog(AlertDialog(
                                    title: Container(
                                      child: SpinKitThreeBounce(
                                        color: Colors.blue,
                                        size: 18.0,
                                      ),
                                    ),
                                  ));

                                  bool _postDeleted =
                                      await parentController.deletePost(postId);

                                  if (_postDeleted) {
                                    removePost.call();
                                    Get.back(closeOverlays: true);
                                  } else {
                                    Get.back(closeOverlays: true);
                                    Get.dialog(AlertDialog(
                                      title: Text(
                                          "Something wrong!!! \n Please try again"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancel")),
                                      ],
                                    ));
                                  }
                                },
                                child: Text("Okay"))
                          ],
                        ));
                      },
                      child: Text('Delete Post'),
                    ),
                    TextButton(
                      onPressed: () {
                        print("okay");
                      },
                      child: Text('Turn off Commenting'),
                    )
                  ],
                ),
              ),
            );
          },
          icon: Icon(
            Icons.more_vert,
            size: 20.0,
          )),
    );
  }
}
