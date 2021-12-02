import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/ProfileReferenceTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SpecificPostRelated/controllers/SpecificPostDisplayPageController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SpecificPostDisplayPageScreen extends StatefulWidget {
  final String postId;

  SpecificPostDisplayPageScreen({Key key, @required this.postId})
      : super(key: key);

  @override
  State<SpecificPostDisplayPageScreen> createState() =>
      _SpecificPostDisplayPageScreenState();
}

class _SpecificPostDisplayPageScreenState
    extends State<SpecificPostDisplayPageScreen> {
  var specificPostData;
  List recommendedPostData;

  @override
  void initState() {
    _getSpecificPostData();

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
              children: [
                ContentDisplayTemplateProvider(
                  data: [specificPostData],useTemplatesAsPostFullDetails: true,
                ),

                ///profile reference
                Container(
                  margin: EdgeInsets.only(bottom: 5.0,top: 5.0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Theme.of(context).accentColor.withOpacity(0.5)))
                  ),
                    child: specificPostData != null
                        ? ProfileReferenceTemplate(
                            userData: specificPostData["postBy"],
                            showVerticalTemplate: false)
                        : Container()),
                // Container(
                //   child: Text(" shared contents will be displayed here"),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  child: Text(
                    "Related Posts:",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
                recommendedPostData == null
                    ? Container()
                    : recommendedPostData.length == 0
                        ? Container()
                        : ContentDisplayTemplateProvider(
                            data: recommendedPostData,
                            useTemplatesAsPostFullDetails: false,
                          ),
                recommendedPostData != null
                    ? ProfileReferenceTemplate(
                        userData: specificPostData["postBy"],
                        showVerticalTemplate: false)
                    : Container()
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
}
