import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/ProfileReferenceTemplate.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';

class PostLikesDisplayPageScreen extends StatefulWidget {
  final String postId;

  const PostLikesDisplayPageScreen({Key key, @required this.postId})
      : super(key: key);

  @override
  State<PostLikesDisplayPageScreen> createState() =>
      _PostLikesDisplayPageScreenState();
}

class _PostLikesDisplayPageScreenState
    extends State<PostLikesDisplayPageScreen> {
  List data;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Likes"),
      ),
      body: data == null
          ? Center(
            heightFactor: 15.0,
              child: CircularProgressIndicator(),
            )
          :data.length==0?Center(
            heightFactor: 5.0,
              child:Text("No likes Yet"),
            ): ListView(
              children: [
                for (var user in data)
                  ProfileReferenceTemplate(
                      userData: user, showVerticalTemplate: false),
              ],
            ),
    );
  }

  _getData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.allPostReaction, {"postId": widget.postId}, userToken);

    if(response!="error"){
      if(this.mounted){
        setState(() {
          data=response;
        });
      }
    }
  }
}
