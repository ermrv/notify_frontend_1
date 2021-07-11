import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPostPageScreen extends StatefulWidget {
  final String description;
  final String postId;
  const EditPostPageScreen(
      {Key key, @required this.description, @required this.postId})
      : super(key: key);

  @override
  _EditPostPageScreenState createState() => _EditPostPageScreenState();
}

class _EditPostPageScreenState extends State<EditPostPageScreen> {
  TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0,top: 15.0,bottom: 15.0),
            child: TextButton(
              onPressed: () {
                _updateDecription();
              },
              child: Text(" Done "),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal:10.0),
              width: screenWidth-20.0,
              child: TextFormField(
                autofocus: true,
                controller: controller,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _updateDecription() async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.editPost,
        {"postId": widget.postId, "description": controller.text}, userToken);

    if (response == "error") {
      print("error");
    } else {
      Get.back(result: controller.text);
    }
  }
}
