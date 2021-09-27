import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/AddPostPageController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ShowSuggestionsWidget extends StatelessWidget {
  final AddPostPageController controller;

  const ShowSuggestionsWidget({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostPageController>(
        builder: (controller) => Container(
              child: controller.tagsSuggestions != null
                  ? ListView(
                      shrinkWrap: true,
                      children: [],
                      //to show tags suggestions
                    )
                  : controller.userSuggestions != null
                      ? ListView(
                          shrinkWrap: true,
                          children: [
                            for (var i in controller.userSuggestions)
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 15.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          ApiUrlsData.domain + i["profilePic"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  i["name"].toString(),
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                onTap: () {
                                  controller.includeName(i["name"]);
                                },
                              )
                          ],
                        )
                      : Center(
                          heightFactor: 50.0,
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
            ));
  }
}
