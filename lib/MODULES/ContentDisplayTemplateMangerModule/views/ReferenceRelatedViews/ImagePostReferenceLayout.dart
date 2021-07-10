import 'package:flutter/material.dart';

class ImagePostReferenceLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
      height: 170.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Top pics:"),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.0,horizontal: 2.0),
            height: 150.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i <= 12; i++)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                                          child: AspectRatio(aspectRatio: 1.0,child: 
                      Image.asset("assets/nature.jpg",fit: BoxFit.cover,),),
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