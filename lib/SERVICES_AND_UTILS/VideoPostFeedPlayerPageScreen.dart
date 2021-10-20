import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/FullVideoPostPlayerTemplate.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  List relatedVideos = [];
  @override
  void initState() {
    _getRelatedVideos();
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FullVideoPostPlayerTemplate(
              postContent: widget.postContent,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                "Related Posts:",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
            for (var i in relatedVideos)
              FullVideoPostPlayerTemplate(postContent: i),
          ],
        ),
      ),
    );
  }

  _getRelatedVideos() async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.relatedPosts,
        {"postId": widget.postContent["videoPost"]["_id"]}, userToken);
    if (response != "error") {
      if (this.mounted) {
        setState(() {
          relatedVideos.addAll(response);
        });
      }
    } else {
      Get.snackbar("error getting specific post data", "/post/detail");
    }
  }
}
