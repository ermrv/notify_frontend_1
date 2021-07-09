import 'package:flutter/material.dart';

class TagsReferenceLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Column(
        children: [
          Container(
            child: Text("Tags"),
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
