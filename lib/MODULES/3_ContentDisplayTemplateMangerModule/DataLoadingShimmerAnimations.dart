import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DataLoadingShimmerAnimations extends StatelessWidget {
  ///post, circle, notification
  final animationType;

  const DataLoadingShimmerAnimations({Key key, @required this.animationType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _getShimmerAnimation(animationType),
    );
  }

  _getShimmerAnimation(String type) {
    switch (type) {
      case "postWithStatus":
        return Container(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            direction: ShimmerDirection.ltr,
            child: ListView(
              children: [
                Container(
                  height: 65.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var i = 0; i <= 10; i++)
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 3.0),
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[500]),
                        )
                    ],
                  ),
                ),
                for (var i = 0; i <= 10; i++)
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                    height: 440.0,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 300.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 30.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 30.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10.0)),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
        break;
      case "postOnly":
        return Container(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            direction: ShimmerDirection.ltr,
            child: ListView(
              children: [
                for (var i = 0; i <= 10; i++)
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                    height: 440.0,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 300.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 30.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 30.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10.0)),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        );

      case "postOnlyColumn":
        return Container(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            direction: ShimmerDirection.ltr,
            child: Column(
              children: [
                for (var i = 0; i <= 10; i++)
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                    height: 440.0,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 300.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 30.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          height: 30.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0)),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      case "notifications":
        return Container(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            direction: ShimmerDirection.ltr,
            child: ListView(
              children: [
                for (var i = 0; i <= 40; i++)
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    height: 60.0,
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                Container(
                                  height: 20.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      default:
    }
  }
}
