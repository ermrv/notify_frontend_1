import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContestPostRelatedViews/ContestPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/EventPostRelatedViews/EventPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImagePostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/PollPostRelatedViews/PollPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ImagePostReferenceLayout.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SharedPostRelatedViews/views/SharedImagePostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SharedPostRelatedViews/views/SharedTextPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SharedPostRelatedViews/views/SharedVideoPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/TextPostRelatedViews/TextPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/VideoPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

///selects the template of the display
class ContentDisplayManager extends GetxController {
  List data;

  //delete a post
  deletePost(String postId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.deletePost, {"postId": postId}, userToken);
    if (response == "error") {
      print("error");
    } else {
      int index = data.indexWhere((post) => post["_id"] == postId);
      if (index != -1) {
        data.removeAt(index);
      }
      update();
    }
  }

  getContentDisplayTemplate(var content) {
    switch (content["postContentType"].toString().toLowerCase()) {
      //for images post
      case "image":
        {
          if (content["primary"].toString() == "true") {
            return ImagePostDisplayTemplate(postContent: content);
          } else if (content["primary"].toString() == "false")
            return SharedImagePostDisplayTemplate(postContent: content);
          break;
        }
      //for video post
      case "video":
        {
          if (content["primary"].toString() == "true") {
            return VideoPostDisplayTemplate(postContent: content);
          } else if (content["primary"].toString() == "false")
            return SharedVideoPostDisplayTemplate(postContent: content);
          break;
        }
        break;

      //for contest post
      case "contest":
        // return Container();
        return ContestPostDisplayTemplate(postContent: content);
        break;

      //for poll post
      case "poll":
        return PollPostDisplayTemplate(
          postContent: content,
        );
        break;

      // for event post
      case "event":
        return EventPostDisplayTemplate(
          postContent: content,
        );
        break;
      case "text":
        {
          if (content["primary"].toString() == "true") {
            return TextPostDisplayTemplate(
              postContent: content,
            );
          } else if (content["primary"].toString() == "false")
            return SharedTextPostDisplayTemplate(
              postContent: content,
            );
        }

        break;

//------------------------------------post reference views-----------------------------------------------------------//

      //for user status or story reference post
      case "imagePostReference":
        return ImagePostReferenceLayout(
            // postContent: content,
            );
        break;

      //for short video post reference
      case "shortVideoPostReference":
        return EventPostDisplayTemplate(
          postContent: content,
        );
        break;

      //for image post reference
      case "imagePostReference":
        return EventPostDisplayTemplate(
          postContent: content,
        );
        break;

      default:
        return Container();
    }
  }
}
