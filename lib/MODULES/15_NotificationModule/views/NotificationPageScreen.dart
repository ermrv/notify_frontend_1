import 'package:MediaPlus/MODULES/13_SearchEngineModule/views/SearchInputPageScreen.dart';
import 'package:MediaPlus/MODULES/15_NotificationModule/controllers/NotificationPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class NotificationPageScreen extends StatelessWidget {
  final controller = Get.put(NotificationPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Notifications"),
        actions: [
          IconButton(
              icon: Icon(
                Feather.search,
                size: 22.0,
              ),
              onPressed: () {
                Get.to(() => SearchInputPageScreen());
              }),
          Container(
            width: 3.0,
          )
        ],
      ),
      body:controller.notificationsData!=null?Center(
        heightFactor: 5.0,
        child: SpinKitThreeBounce(color: Colors.blue,size: 18.0,),
      ): ListView(
        children: [
          getNotificationTemaplate("like"),
          getNotificationTemaplate("comment"),
          getNotificationTemaplate("follow")
        ],
      ),
    );
  }

  Container getNotificationTemaplate(String notificationType) {
    switch (notificationType.toLowerCase()) {
      case "like":
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 35.0,
                  width: 35.0,
                  child: Image.asset(
                    "assets/person.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 4.0,
              ),
              Expanded(
                  child: Container(
                    child: Text("Mani, rahul and 41 others like your post",
                        style: TextStyle(fontSize: 15.0)),
                  )),
              ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  child: Image.asset(
                    "assets/nature.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case "comment":
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 35.0,
                  width: 35.0,
                  child: Image.asset(
                    "assets/person.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 4.0,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "Mani commented on your post: waah bro,ky baat h yaar",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  child: Image.asset(
                    "assets/nature.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case "follow":
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 35.0,
                  width: 35.0,
                  child: Image.asset(
                    "assets/person.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 4.0,
              ),
              Expanded(
                  child: Container(
                child: Text("Mani started following you",
                    style: TextStyle(fontSize: 15.0)),
              )),
              TextButton(
                onPressed: () {},
                child: Text("Follow Back"),
              )
            ],
          ),
        );
        break;
      default:
        return Container();
    }
  }
}
