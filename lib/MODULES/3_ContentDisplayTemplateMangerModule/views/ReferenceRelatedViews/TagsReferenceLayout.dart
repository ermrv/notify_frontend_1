import 'package:flutter/material.dart';

class TagsReferenceLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 70.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Trending Tags:"),
          ),
          Container(
            height: 45.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i <= 12; i++)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 1.0,horizontal: 2.0),
                    padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).accentColor,width: 0.5),
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text("#kindness",style: TextStyle(color: Colors.blue,fontSize: 15.0,fontStyle: FontStyle.italic),),
                        ),
                        Container(
                          child: Text("3.2k posts",style: TextStyle(fontSize: 12.0)),
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
