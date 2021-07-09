import 'package:flutter/material.dart';


class ContestPostReferenceLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Column(
        children: [
          Container(
            child: Text("Contest:"),
          ),
          Container(
            height: 80.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i <= 12; i++)
                  Container(
                    width: 200.0,
                    child: Column(
                      children: [
                        Container(
                          width: 200.0,
                          height: 150.0,
                          child: Text("#kindness"),
                        ),
                        Container(
                          child: Text("3.2k posts"),
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