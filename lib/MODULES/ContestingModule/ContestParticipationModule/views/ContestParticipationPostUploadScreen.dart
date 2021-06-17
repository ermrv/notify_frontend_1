import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/ContestingModule/ContestParticipationModule/controllers/ContestParticipationPostUploadScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContestParticipationPostUploadScreen extends StatelessWidget {
  final String contestId;
  final String contestName;

  ContestParticipationPostUploadScreen(
      {Key key, @required this.contestId, @required this.contestName})
      : super(key: key);

  final controller = Get.put(ContestParticipationPostUploadScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContestParticipationPostUploadScreenController>(
      initState: (state) {
        controller.contestId = contestId;
        controller.contestName = contestName;
      },
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(contestName),
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: TextButton(
                    onPressed: () {
                      controller.handlePostButtonClick();
                    },
                    child: Text("Post")),
              ),
              Container(
                child: IconButton(icon: Icon(Icons.help), onPressed: () {}),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: controller.contestPostFile == null
                      ? AspectRatio(
                          aspectRatio: 3 / 4,
                          child: GestureDetector(
                              onTap: () {
                                controller.getFile();
                              },
                              child: Container(
                                child: AspectRatio(
                                  aspectRatio: 3 / 4,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          controller.contestContentType == "image"
                                              ? Icon(
                                                  Icons.add_a_photo,
                                                  size: 20.0,
                                                )
                                              : Icon(
                                                  Icons.ondemand_video,
                                                  size: 20.0,
                                                ),
                                          Container(
                                              margin: EdgeInsets.only(top: 8.0),
                                              child: controller
                                                          .contestContentType ==
                                                      "image"
                                                  ? Text(
                                                      "Choose Image(3:4 prefered)")
                                                  : Text("Choose Video"))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        )
                      : Stack(
                          children: [
                            Container(
                              //view selected using content type
                              child: controller.contestContentType == "image"
                                  ? AspectRatio(
                                      aspectRatio: 3 / 4,
                                      child: Container(
                                        child: Image.file(
                                          controller.contestPostFile,
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                  : Container(
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all()),
                                      child: FutureBuilder(
                                          future: controller.getThumbnail(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return Image.memory(
                                                snapshot.data,
                                              );
                                            }
                                            return Container();
                                          }),
                                    ),
                            ),
                            Positioned(
                                bottom: 0.0,
                                right: 5.0,
                                child: TextButton(
                                    onPressed: () {
                                      controller.getFile();
                                    },
                                    child: Text(" Change ")))
                          ],
                        ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        width: screenWidth,
                        child: TextFormField(
                          controller: controller.discriptionEditingController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Add Discription..",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tags:",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        width: screenWidth,
                        child: TextFormField(
                          controller: controller.tagsEditingController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Add tags (max 30)..",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
