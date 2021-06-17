import 'package:MediaPlus/MODULES/UserProfileModule/views/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryUserActionsOnProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                child: Container(
                    alignment: Alignment.center,
                    
                    child: Text("Follow")),
                onPressed: () {
                  
                }),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                child: Container(
                    alignment: Alignment.center,
                    child: Text("Contests")),
                onPressed: () {
                  print("Promotions");
                }),
          ),
          Expanded(
            child: Container(),
          ),
          ///to navigate to the grid view of the psots
          IconButton(icon: Icon(Icons.keyboard_arrow_down),onPressed: () {})
        ],
      ),
    );
  }
}
