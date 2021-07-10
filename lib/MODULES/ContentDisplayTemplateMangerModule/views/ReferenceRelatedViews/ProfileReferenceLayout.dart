import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const double _containerWidth = 120.0;

class ProfileReferenceLayout extends StatelessWidget {
  final boxContents;

  const ProfileReferenceLayout({Key key, this.boxContents}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      height: 225.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text("People you may know:"),
          ),
          Container(
            height: 195.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i <= 12; i++)
                  Container(
                    width: 150.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).accentColor, width: 0.5),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin:EdgeInsets.only(top: 5.0),
                          child: SizedBox(
                            height: 130.0,
                            width: 130,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.asset(
                                  "assets/nature.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Name",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          height: 28.0,
                          child: TextButton(
                            onPressed: () {},
                            child: Container(
                             
                              alignment: Alignment.center,
                              child: Text("Follow",
                                  style: TextStyle(fontSize: 14.0)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
