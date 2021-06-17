import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/HomePageModule/views/HomePageScreen.dart';
import 'package:MediaPlus/MODULES/MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/UserProfileModule/views/UserProfileScreen.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class StatusUploaderScreen extends StatefulWidget {
  final String contentType;
  final List<File> files;

  const StatusUploaderScreen(
      {Key key, @required this.files, @required this.contentType})
      : super(key: key);
  @override
  _StatusUploaderScreenState createState() => _StatusUploaderScreenState();
}

class _StatusUploaderScreenState extends State<StatusUploaderScreen> {
  @override
  void initState() {
    _uploadFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.files);
    return Scaffold(
      body: Center(
        heightFactor: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SpinKitHourGlass(
                color: Colors.blue,
              ),
            ),
            Container(
              height: 10.0,
            ),
            Text("Uploading..."),
          ],
        ),
      ),
    );
  }

  _uploadFiles() async {
    List<File> _files = widget.files;
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiUrlsData.addStatus));
    request.headers["authorization"] = "Bearer " + userToken;
    request.headers["Content-type"] = "multipart/form-data";
    request.fields['statusText'] = "Not needed";
    // request.fields["postContentType"] = widget.contentType;
    for (File i in _files) {
      request.files.add(await http.MultipartFile.fromPath(
        "statusFile",
        i.path,
        contentType: MediaType(
            widget.contentType.toString(), i.path.split(".").last.toString()),
      ));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      print(response);
      // Get.offUntil(GetPageRoute(page: () => UserProfileScreen()),(route)=>Get.until((route) =>Get.isDialogOpen);
      Get.off(() => MainNavigationScreen());
    } else {
      print(response.statusCode);
    }
  }
}
