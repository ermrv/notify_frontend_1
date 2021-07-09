import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const double _containerWidth = 120.0;

class ProfileReferenceLayout extends StatelessWidget {
  final boxContents;

  const ProfileReferenceLayout({Key key, @required this.boxContents})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.only(left: 1.0, bottom: 1.0, right: 1.0),
      child: Container(
        margin: EdgeInsets.only(left: 1.0),
        padding: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
            // color: Colors.red,
            ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5.0),
              alignment: Alignment.bottomLeft,
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(boxContents["title"].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.0)),
                  Container(
                      child: Text(
                    "view all >>  ",
                    style: TextStyle(color: Colors.blue),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i in boxContents["contents"])
                    _Template(
                      content: i,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Template extends StatelessWidget {
  final content;

  const _Template({Key key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(left: 5.0),
      child: Stack(
        children: [
          //post
          Container(
            width: _containerWidth,
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                imageUrl: ApiUrlsData.domain + content["profilePic"].toString(),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
              top: 3.0,
              child: Container(
                alignment: Alignment.topCenter,
                width: _containerWidth,
                child: Text(
                  "Maniraj",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
                ),
              )),
          Positioned(
              bottom: -6.0,
              child: Container(
                decoration: BoxDecoration(
                   
                    borderRadius: BorderRadius.circular(8.0)),
                height: 32.0,
                width: _containerWidth,
                alignment: Alignment.center,
                child: TextButton(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Follow",
                        style: TextStyle(),
                      )),
                  onPressed: () {
                    print("followed");
                  },
                ),
              ))
        ],
      ),
    );
  }
}
