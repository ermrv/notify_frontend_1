import 'package:flutter/material.dart';

const double _containerWidth = 120.0;

class ContestWinneProfileReferenceTemplate extends StatelessWidget {
  final boxContents;

  const ContestWinneProfileReferenceTemplate(
      {Key key, @required this.boxContents})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      height: 190,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var i in boxContents["contents"])
            _Template(
              content: i,
            ),
        ],
      ),
    );
  }
}

class _Template extends StatelessWidget {
  final content;

  const _Template({Key key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //post
        Container(
          width: _containerWidth,
          height: double.infinity,
          margin: EdgeInsets.only(right: 4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.asset(
              "assets/nature.jpg",
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
                border: Border.all(color: Colors.white, width: 3.0),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  30.0,
                ),
                child: Image.asset(
                  "assets/person.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            )),
        Positioned(
            top: 3.0,
            child: Container(
              alignment: Alignment.topCenter,
              width: _containerWidth,
              child: Text(
                "Maniraj",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
              ),
            ))
      ],
    );
  }
}
