import 'dart:io';

import 'package:MediaPlus/MODULES/AddPostModule/controllers/ImageDisplayTemplateSelectorController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageDisplayTemplateSelector extends StatelessWidget {
  final List<File> files;
  final List<double> aspectRatio;
  final ImageDisplayTemplateSelectorController controller =
      Get.put(ImageDisplayTemplateSelectorController());

  ImageDisplayTemplateSelector(
      {Key key, @required this.files, @required this.aspectRatio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageDisplayTemplateSelectorController>(
        initState: (state) {
          controller.files = files;
          controller.aspectRatio = aspectRatio;
          controller.initialise();
        },
        builder: (controller) => Scaffold(
              bottomNavigationBar: files.length == 1
                  ? Container()
                  : Container(
                      height: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 10.0),
                            child: Text(" Choose Layout:"),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: files.length == 2
                                ? Row(
                                    children: [
                                      ///vertical template
                                      GestureDetector(
                                        onTap: () {
                                          controller.updateTemplate("vertical");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: controller
                                                              .templateType ==
                                                          "vertical"
                                                      ? Colors.blue[100]
                                                      : Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.6))),
                                          width: 50.0,
                                          child: AspectRatio(
                                            aspectRatio: 0.8,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: controller
                                                                .templateType ==
                                                            "vertical"
                                                        ? Colors.blue[100]
                                                        : Theme.of(context)
                                                            .accentColor
                                                            .withOpacity(0.6),
                                                  ),
                                                  width: 50.0,
                                                  height: 20.0,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: controller
                                                                .templateType ==
                                                            "vertical"
                                                        ? Colors.blue[100]
                                                        : Theme.of(context)
                                                            .accentColor
                                                            .withOpacity(0.6),
                                                  ),
                                                  width: 50.0,
                                                  height: 20.0,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 10.0,
                                      ),

                                      ///horizontal template
                                      GestureDetector(
                                        onTap: () {
                                          controller
                                              .updateTemplate("horizontal");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: controller
                                                              .templateType ==
                                                          "horizontal"
                                                      ? Colors.blue[100]
                                                      : Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.6))),
                                          width: 50.0,
                                          child: AspectRatio(
                                            aspectRatio: 0.8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: controller
                                                                .templateType ==
                                                            "horizontal"
                                                        ? Colors.blue[100]
                                                        : Theme.of(context)
                                                            .accentColor
                                                            .withOpacity(0.6),
                                                  ),
                                                  width: 20.0,
                                                  height: 50.0,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: controller
                                                                .templateType ==
                                                            "horizontal"
                                                        ? Colors.blue[100]
                                                        : Theme.of(context)
                                                            .accentColor
                                                            .withOpacity(0.6),
                                                  ),
                                                  width: 20.0,
                                                  height: 50.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller
                                              .updateTemplate("imageCarousel");
                                        },
                                        child: Container(
                                          width: 50.0,
                                          height: 60.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: controller
                                                              .templateType ==
                                                          "imageCarousel"
                                                      ? Colors.blue[100]
                                                      : Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.6))),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: controller.templateType ==
                                                      "imageCarousel"
                                                  ? Colors.blue[100]
                                                  : Theme.of(context)
                                                      .accentColor
                                                      .withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      ///vertical template
                                      GestureDetector(
                                        onTap: () {
                                          controller.updateTemplate("vertical");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: controller
                                                              .templateType ==
                                                          "vertical"
                                                      ? Colors.blue[100]
                                                      : Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.6))),
                                          width: 60.0,
                                          height: 60.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color:
                                                      controller.templateType ==
                                                              "vertical"
                                                          ? Colors.blue[100]
                                                          : Theme.of(context)
                                                              .accentColor
                                                              .withOpacity(0.6),
                                                ),
                                                width: 50.0,
                                                height: 20.0,
                                              ),
                                              Container(
                                                width: 50.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: controller
                                                                    .templateType ==
                                                                "vertical"
                                                            ? Colors.blue[100]
                                                            : Theme.of(context)
                                                                .accentColor
                                                                .withOpacity(
                                                                    0.6),
                                                      ),
                                                      width: 24.0,
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: controller
                                                                    .templateType ==
                                                                "vertical"
                                                            ? Colors.blue[100]
                                                            : Theme.of(context)
                                                                .accentColor
                                                                .withOpacity(
                                                                    0.6),
                                                      ),
                                                      width: 24.0,
                                                      height: 20.0,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 10.0,
                                      ),

                                      ///horizontal template
                                      GestureDetector(
                                        onTap: () {
                                          controller
                                              .updateTemplate("horizontal");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: controller
                                                              .templateType ==
                                                          "horizontal"
                                                      ? Colors.blue[100]
                                                      : Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.6))),
                                          width: 60.0,
                                          height: 60.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color:
                                                      controller.templateType ==
                                                              "horizontal"
                                                          ? Colors.blue[100]
                                                          : Theme.of(context)
                                                              .accentColor
                                                              .withOpacity(0.6),
                                                ),
                                                width: 20.0,
                                                height: 50.0,
                                              ),
                                              Container(
                                                height: 50.0,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: controller
                                                                    .templateType ==
                                                                "horizontal"
                                                            ? Colors.blue[100]
                                                            : Theme.of(context)
                                                                .accentColor
                                                                .withOpacity(
                                                                    0.6),
                                                      ),
                                                      width: 20.0,
                                                      height: 24.0,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: controller
                                                                    .templateType ==
                                                                "horizontal"
                                                            ? Colors.blue[100]
                                                            : Theme.of(context)
                                                                .accentColor
                                                                .withOpacity(
                                                                    0.6),
                                                      ),
                                                      width: 20.0,
                                                      height: 24.0,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller
                                              .updateTemplate("imageCarousel");
                                        },
                                        child: Container(
                                          width: 50.0,
                                          height: 60.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: controller
                                                              .templateType ==
                                                          "imageCarousel"
                                                      ? Colors.blue[100]
                                                      : Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.6))),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: controller.templateType ==
                                                      "imageCarousel"
                                                  ? Colors.blue[100]
                                                  : Theme.of(context)
                                                      .accentColor
                                                      .withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          )
                        ],
                      )),
              appBar: AppBar(
                title: Text("Select  layout"),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    height: 30.0,
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Container(
                        height: 21.0,
                        alignment: Alignment.center,
                        child: Text(" Done "),
                      ),
                      onPressed: () {
                        controller.getBack();
                      },
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      controller.getTemplate(controller.templateType),
                    ],
                  ),
                ),
              ),
            ));
  }
}
