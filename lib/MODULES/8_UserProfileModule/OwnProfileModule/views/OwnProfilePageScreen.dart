import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/PrimaryUserActionsOnProfile.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/PrimaryUserBasicInfoContainer.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///for displaying user own profiile data
///uses the [ContentDisplayTemplateProvider] for displaying posts
class OwnProfilePageScreen extends StatefulWidget {
  @override
  _OwnProfilePageScreenState createState() => _OwnProfilePageScreenState();
}

class _OwnProfilePageScreenState extends State<OwnProfilePageScreen> {
  List postData;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: MediaQuery.removePadding(
          context: context,
          child: ListView(
            children: [
              PrimaryUserBasicInfoContainer(),

              PrimaryUserActionsOnProfile(),

              postData == null
                  ? Center(
                      child: SpinKitPulse(
                        color: Colors.blue,
                      ),
                    ):postData.length==0?Center(
                      child: Text("No posts yet!!!"),
                    )
                  : ContentDisplayTemplateProvider(
                      data: postData,
                    )
              // PrimaryUserHighlightsContainer(),
            ],
          )),
    );
  }

  _getData() async {
    var response =
        await ApiServices.postWithAuth(ApiUrlsData.userPosts, {}, userToken);
    if (response != "error") {
      postData = response;
      if (this.mounted) {
        setState(() {});
      }
    }
  }
}
