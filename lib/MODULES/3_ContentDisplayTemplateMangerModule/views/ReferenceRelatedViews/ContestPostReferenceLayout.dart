import 'package:flutter/material.dart';

class ContestPostReferenceLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      height: 210.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Contest:"),
          ),
          Container(
            height: 190.0,
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
                          height: 150.0,
                          
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.asset(
                                "assets/nature.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text("Contest Name",overflow: TextOverflow.ellipsis,),
                        ),
                        Container(
                          child: Text("Prize worth Rs.25k",style:TextStyle(fontSize: 12.0)),
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
