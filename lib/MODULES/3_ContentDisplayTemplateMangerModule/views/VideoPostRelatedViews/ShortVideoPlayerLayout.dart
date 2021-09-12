import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/ShortVideoPlayerTemplate.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

///stateful widget with scafold,page view layout as body and
/// having the [ShortVideoPlayerTemplate] as children
///
/// [_ShortVideoPlayerLayoutState._getData] to get the related video contents
class ShortVideoPlayerLayout extends StatefulWidget {
  final postContent;

  const ShortVideoPlayerLayout({Key key, @required this.postContent})
      : super(key: key);
  @override
  _ShortVideoPlayerLayoutState createState() => _ShortVideoPlayerLayoutState();
}

class _ShortVideoPlayerLayoutState extends State<ShortVideoPlayerLayout> {
  List videos = [];

  @override
  void initState() {
    videos.add(widget.postContent);
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    videos = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(videos[0]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          for (var i in videos) ShortVideoPlayerTemplate(postContent: i)
        ],
      ),
    );
  }

  _getData() async {
    // var response = await ApiServices.post(ApiUrlsData.videosUrl, {});
  }
}
