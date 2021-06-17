import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ContestPostRelatedViews/ContestPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/EventPostRelatedViews/EventPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImagePostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/PollPostRelatedViews/PollPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/TextPostRelatedViews/TextPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/VideoPostDisplayTemplate.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

///selects the template of the display
class ContentDisplayManager extends GetxController {
  getContentDisplayTemplate(var content) {
    print(content["postContentType"].toString().toLowerCase());
    switch (content["postContentType"].toString().toLowerCase()) {
      //for images post
      case "image":
        return ImagePostDisplayTemplate(postContent: content);
        break;

      //for video post
      case "video":
        return VideoPostDisplayTemplate(postContent: content);
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
        return TextPostDisplayTemplate(
          postContent: content,
        );
        break;

//------------------------------------post reference views-----------------------------------------------------------//

      //for user status or story reference post
      case "userStoryReference":
        return EventPostDisplayTemplate(
          postContent: content,
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
