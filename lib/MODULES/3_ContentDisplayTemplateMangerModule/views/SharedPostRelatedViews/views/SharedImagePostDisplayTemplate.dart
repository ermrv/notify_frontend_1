import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImagePostDisplayTemplate.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:flutter/material.dart';

class SharedImagePostDisplayTemplate extends StatelessWidget {
  final postContent;

  const SharedImagePostDisplayTemplate({Key key,@required this.postContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth,
      child: Column(
        children: [
          Container(
            child:ReadMoreText(
                    postContent["sharedDiscription"]
                        .toString(),
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).accentColor.withOpacity(0.9)),
                    trimLines: 2,
                    trimCollapsedText: "...more",
                    trimExpandedText: "  less",
                    trimMode: TrimMode.Line,
                    colorClickableText: Colors.blue,
                  ),
          ),
          Container(
            child: ImagePostDisplayTemplate(postContent: postContent,),
          )
        ],
      ),
    );
  }
}
