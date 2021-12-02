import 'package:MediaPlus/MODULES/1_AddPostModule/views/EditPostPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/controllers/ContentDisplayTemplateManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostOwnerActionsOnPost extends StatelessWidget {
  final String postId;
  final String postDescription;
  final Function(String) editedDescriptionUpdater;
  final parentController;

  const PostOwnerActionsOnPost(
      {Key key,
      @required this.postId,
      @required this.postDescription,
      @required this.editedDescriptionUpdater,
      @required this.parentController})
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
                                  await parentController.deletePost(postId);
                                  Get.back();
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
