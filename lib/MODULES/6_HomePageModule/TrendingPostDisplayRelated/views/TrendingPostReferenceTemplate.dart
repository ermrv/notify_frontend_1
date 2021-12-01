import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/6_HomePageModule/TrendingPostDisplayRelated/views/TrendingPostDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _containerWidth = 60.0;

class TrendingPostReferenceTemplate extends StatelessWidget {
  final List data;

  const TrendingPostReferenceTemplate({Key key, @required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      height: _containerWidth + 16,
      child: ListView(
        key: PageStorageKey("tendingPostReferenceTemplateKey"),
        scrollDirection: Axis.horizontal,
        children: [
          data.length == 0 ? _BlankTemplate() : Container(),
          for (var i in data)
            _Template(
              content: i,
              data: data,
            ),
        ],
      ),
    );
  }
}

///when data is not present
class _BlankTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _containerWidth,
      height: _containerWidth,
      margin: EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: PrimaryUserData.primaryUserData.profilePic == null
            ? Image.asset(
                "assets/person.jpg",
                fit: BoxFit.fill,
              )
            : CachedNetworkImage(
                imageUrl: PrimaryUserData.primaryUserData.profilePic.toString(),
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}

///when data is present
class _Template extends StatelessWidget {
  final List data;
  final content;

  const _Template({Key key, this.content, @required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int initialIndex = data.indexOf(content);
        Get.to(() => TrendingPostDisplayPageScreen(
            trendingPostIdList: data, initialIndex: initialIndex));
      },
      child: Container(
        margin: EdgeInsets.only(right: 3.0),
        height: _containerWidth,
        width: _containerWidth,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[200], width: 2.0),
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            40.0,
          ),
          child:CachedNetworkImage(
                  imageUrl:
                      ApiUrlsData.domain + content["userProfilePic"].toString(),
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}
