import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/controllers/ContentDisplayTemplateManager.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceLayout.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ShortVideosPostReferenceLayout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

///all the content display templates is managed by this widget
///
///returns a column consisting of the related templates
///
///GIVEN list of data as input
///
///uses the postType key to find the corresponding template
class ContentDisplayTemplateProvider extends StatelessWidget {
  final List data;

  ContentDisplayTemplateProvider({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i in data) getContentDisplayTemplate(i),
      ],
    );
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
      case "profilereference":
        return ProfileReferenceLayout(
          boxContents: content,
        );
        break;
      //for user status or story reference post
      case "imagePostReference":
        return ImagePostReferenceLayout(
            // postContent: content,
            );
        break;

      //for short video post reference
      case "shortvideoreference":
        return ShortVideosPostReferenceLayout(boxContents: content);

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
