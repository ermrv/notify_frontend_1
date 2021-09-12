import 'package:MediaPlus/MODULES/1_AddPostModule/views/EditPostPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/controllers/ContentDisplayTemplateManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class PostOwnerActionsOnPost extends StatelessWidget {
  final String postId;
  final String postDescription;
  final Function(String) editedDescriptionUpdater;

  const PostOwnerActionsOnPost(
      {Key key,
      @required this.postId,
      @required this.postDescription,
      @required this.editedDescriptionUpdater})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton<TextButton>(
        elevation: 0.0,
        padding: EdgeInsets.all(2.0),
        itemBuilder: (context) {
          return [
            PopupMenuItem<TextButton>(
                child: TextButton(
              onPressed: () async {
                String description = await Get.to(() => EditPostPageScreen(
                      description: postDescription,
                      postId: postId,
                    ));

                editedDescriptionUpdater.call(description);
              },
              child: Text('Edit Post'),
            )),
            PopupMenuItem<TextButton>(
                child: TextButton(
              onPressed: () {
                ContentDisplayManager _controller =
                    Get.find<ContentDisplayManager>();
                _controller.deletePost(postId);
              },
              child: Text('Delete Post'),
            )),
            PopupMenuItem<TextButton>(
                child: TextButton(
              onPressed: () {
                print("okay");
              },
              child: Text('Turn off Commenting'),
            )),
          ];
        },
      ),
    );
  }
}
