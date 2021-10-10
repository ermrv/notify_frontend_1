import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/FullVideoPostPlayerTemplate.dart';
import 'package:flutter/material.dart';

///page to play full length video
///
///contains the realted video post
class VideoPostFeedPlayerPageScreen extends StatefulWidget {
  final postContent;

  const VideoPostFeedPlayerPageScreen({Key key, @required this.postContent})
      : super(key: key);

  @override
  _VideoPostFeedPlayerPageScreenState createState() =>
      _VideoPostFeedPlayerPageScreenState();
}

class _VideoPostFeedPlayerPageScreenState
    extends State<VideoPostFeedPlayerPageScreen> {
  List videos = [];
  @override
  void initState() {
    videos.add(widget.postContent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i in videos)
              FullVideoPostPlayerTemplate(
                postContent: i,
                id: "4",
              ),
          ],
        ),
      ),
    );
  }
}
