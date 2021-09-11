import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommonPostDisplayPageScreen extends StatefulWidget {
  final String title;
  final String apiUrl;
  final Map<String, dynamic> apiData;

  const CommonPostDisplayPageScreen(
      {Key key, this.title, @required this.apiUrl, @required this.apiData})
      : super(key: key);
  @override
  _CommonPostDisplayPageScreenState createState() =>
      _CommonPostDisplayPageScreenState();
}

class _CommonPostDisplayPageScreenState
    extends State<CommonPostDisplayPageScreen> {
  List data;
  String title = "Posts";
  @override
  void initState() {
    _getData();
    if (widget.title != null) {
      title = widget.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: data == null
          ? Container(
              child: Center(
                child: SpinKitPulse(
                  color: Colors.blue,
                ),
              ),
            ):data.length==0?Center(
              child: Text("No post yet!!"),
            )
          : ListView(
              children: [
                ContentDisplayTemplateProvider(
                  data: data,
                )
              ],
            ),
    );
  }

  _getData() async {
    var response = await ApiServices.postWithAuth(
        widget.apiUrl, widget.apiData, userToken);

    if (response != "error") {
      if (data == null) {
        data = response;
      } else {
        data.addAll(response);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    data = null;
    super.dispose();
  }
}
