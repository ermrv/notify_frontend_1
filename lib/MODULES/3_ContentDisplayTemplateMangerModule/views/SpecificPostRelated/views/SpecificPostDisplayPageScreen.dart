import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/ProfileReferenceTemplate.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/DataLoadingShimmerAnimations.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/PostGettingServices/GettingPostServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SpecificPostDisplayPageScreen extends StatefulWidget {
  final String postId;
  final postContent;

  SpecificPostDisplayPageScreen(
      {Key key, @required this.postId, this.postContent})
      : super(key: key);

  @override
  State<SpecificPostDisplayPageScreen> createState() =>
      _SpecificPostDisplayPageScreenState();
}

class _SpecificPostDisplayPageScreenState
    extends State<SpecificPostDisplayPageScreen> {
  var specificPostData;
  List recommendedPostData;
  bool isLoadingMoreData = false;
  ScrollController scrollController;

  @override
  void initState() {
    if (widget.postContent == null) {
      _getSpecificPostData();
    } else {
      specificPostData = widget.postContent;
      _getRecommendedPostData();
    }
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: specificPostData == null
          ? Center(
              heightFactor: 5.0,
              child: SpinKitPulse(
                color: Colors.blue,
              ),
            )
          : ListView(
              controller: scrollController,
              children: [
                ContentDisplayTemplateProvider(
                  data: [specificPostData],
                  useTemplatesAsPostFullDetails: true,
                ),

                ///profile reference
                Container(
                    margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5)))),
                    child: specificPostData != null
                        ? ProfileReferenceTemplate(
                            userData: specificPostData["postBy"],
                            showVerticalTemplate: false)
                        : Container()),
                // Container(
                //   child: Text(" shared contents will be displayed here"),
                // ),
                recommendedPostData != null
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: Text(
                          "Related Posts:",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(),
                recommendedPostData == null
                    ? DataLoadingShimmerAnimations(
                        animationType: "postOnlyColumn")
                    : recommendedPostData.length == 0
                        ? Container()
                        : ContentDisplayTemplateProvider(
                            data: recommendedPostData,
                            useTemplatesAsPostFullDetails: false,
                          ),
                isLoadingMoreData
                    ? Container(
                        height: 30.0,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.blue,
                        )),
                      )
                    : Container(
                        height: 30.0,
                      ),
              ],
            ),
    );
  }

  _getSpecificPostData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.specificPostDetail, {"postId": widget.postId}, userToken);
    if (response != "error") {
      if (this.mounted) {
        setState(() {
          specificPostData = response;
        });
      }
      _getRecommendedPostData();
    } else {
      Get.snackbar("error getting specific post data", "/post/detail");
    }
  }

  _getRecommendedPostData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.relatedPosts, {"postId": widget.postId}, userToken);
    if (response != "error") {
      if (this.mounted) {
        setState(() {
          recommendedPostData = response;
        });
      }
    } else {
      Get.snackbar("error getting specific post data", "/post/detail");
    }
  }

  ///get more data
  ///
  ///
  ///
  /// to get the previous post data
  getPreviousPostsData() async {
    if (this.mounted) {
      setState(() {
        isLoadingMoreData = true;
      });
    }
    String _lastPostId = GettingPostServices.getLastPostId(recommendedPostData);
    print(_lastPostId);

    var response = await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl,
        {"dataType": "previous", "postId": _lastPostId}, userToken);

    if (response != "error") {
      if (recommendedPostData == null) {
        recommendedPostData = response;
        if (this.mounted) {
          setState(() {
            isLoadingMoreData = false;
          });
        }
      } else {
        recommendedPostData.addAll(response);
        if (this.mounted) {
          setState(() {
            isLoadingMoreData = false;
          });
        }
      }
    } else {
      if (this.mounted) {
        setState(() {
          isLoadingMoreData = false;
        });
      }
      Get.snackbar("Cannot get the data", "some error occured");
    }
  }

  ///listen to the scroll of the newfeed in order to load more data
  ///calls [getPreviousPostsData] when scroll is attend to a limit
  scrollListener() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      getPreviousPostsData();
    }
  }
}
