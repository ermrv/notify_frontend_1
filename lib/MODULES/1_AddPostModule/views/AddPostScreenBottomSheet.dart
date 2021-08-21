import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/AddPostPageController.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/CreateEventPageScreen.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/CreatePollPageScreen.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestHostingModule/views/CreateContestScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostScreenBottomSheet extends StatelessWidget {
  final AddPostPageController controller = Get.find<AddPostPageController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostPageController>(
      builder: (controller) => Card(
        child: Container(
          height: 260.0,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  width: 50.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.transparent),
                      side: MaterialStateProperty.resolveWith(
                          (states) => BorderSide.none)),
                  onPressed: () {},
                  child: Row(
                    children: [Icon(Icons.image), Text("   Add Images")],
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.transparent),
                      side: MaterialStateProperty.resolveWith(
                          (states) => BorderSide.none)),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.ondemand_video),
                      Text("   Add Video")
                    ],
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.transparent),
                      side: MaterialStateProperty.resolveWith(
                          (states) => BorderSide.none)),
                  onPressed: () {
                    Get.off(() => CreateEventPageScreen());
                  },
                  child: Row(
                    children: [Icon(Icons.event), Text("   Create Event")],
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.transparent),
                      side: MaterialStateProperty.resolveWith(
                          (states) => BorderSide.none)),
                  onPressed: () {
                    Get.off(() => CreatePollPageScreen());
                  },
                  child: Row(
                    children: [Icon(Icons.poll), Text("   Create Poll")],
                  )),
              // TextButton(
              //     style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.resolveWith(
              //             (states) => Colors.transparent),
              //         side: MaterialStateProperty.resolveWith(
              //             (states) => BorderSide.none)),
              //     onPressed: () {
              //       Get.off(() => CreateContestScreen());
              //     },
              //     child: Row(
              //       children: [
              //         Icon(Icons.emoji_events),
              //         Text("   Create Contest")
              //       ],
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
