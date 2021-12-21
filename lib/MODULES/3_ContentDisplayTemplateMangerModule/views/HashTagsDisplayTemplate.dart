import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/controllers/CommonPostDisplayPageController.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/CommonPostDisplayPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashTagsDisplayTemplate extends StatelessWidget {
  final hashTagData;

  const HashTagsDisplayTemplate({Key key, @required this.hashTagData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: TextButton(
        onPressed: () {
          Get.to(() => CommonPostDisplayPageScreen(
              title: hashTagData["hashtag"].toString(),
              apiUrl: ApiUrlsData.tagRelatedPosts,
              apiData: {"hashtag": hashTagData["hashtag"].toString()}));
        },
        child: Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  hashTagData["hashtag"].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  hashTagData["count"].toString() + " Posts",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
