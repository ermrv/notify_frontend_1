import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:flutter/material.dart';


const double _containerWidth = 210.0;

class ContestReferenceLayout extends StatelessWidget {
  final boxContents;

  const ContestReferenceLayout({Key key, this.boxContents}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin:EdgeInsets.only(left: 1.0,bottom: 1.0,right: 1.0),
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
                                    Container(child: Text("view all >>  ",style: TextStyle(color: Colors.blue),)),

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
      child: Container(
        child: GestureDetector(
          onTap: () {
          },
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
                  child: Image.asset(
                    "assets/nature.jpg",
                    // ApiUrlsData.domain + content["postContent"][0]["thumbnail"],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              //user profile pic
              Positioned(
                  bottom: -10.0,
                  left: _containerWidth / 2 - 25.0,
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3.0),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                      child: Image.network(
                        ApiUrlsData.domain + content["postBy"]["profilePic"],
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              Positioned(
                  top: 0.0,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: _containerWidth,
                    child: Text(
                      content["postBy"]["name"],
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w800),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
