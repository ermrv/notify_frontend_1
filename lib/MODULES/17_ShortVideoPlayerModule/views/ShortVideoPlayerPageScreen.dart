import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';

import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/ShortVideoPlayerTemplate.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///stateful widget with scafold,page view layout as body and
/// having the [ShortVideoPlayerTemplate] as children
///
/// [_ShortVideoPlayerLayoutState._getData] to get the related video contents
class ShortVideoPlayerPageScreen extends StatefulWidget {
  final postContent;

  const ShortVideoPlayerPageScreen({Key key, this.postContent})
      : super(key: key);
  @override
  _ShortVideoPlayerPageScreenState createState() =>
      _ShortVideoPlayerPageScreenState();
}

class _ShortVideoPlayerPageScreenState
    extends State<ShortVideoPlayerPageScreen> {
  List videos = [];

  @override
  void initState() {
    if (widget.postContent !=null) {
      videos.add(widget.postContent);
    }
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: videos.length == 0
          ? Center(
              child: SpinKitPulse(
                color: Colors.blue,
                size: 18,
              ),
            )
          : PageView(
              scrollDirection: Axis.vertical,
              children: [
                for (var i in videos) ShortVideoPlayerTemplate(postContent: i)
              ],
            ),
    );
  }

  _getData() async {
    var response =
        await ApiServices.postWithAuth(ApiUrlsData.shortVideos, {}, userToken);
    if (response != "error") {
      videos.addAll(response);
    }
    setState(() {});
  }
}
