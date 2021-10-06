import 'dart:io';

import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/ImageCarouselDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/MultiImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/MultiImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/SingleImageDisplayTemplate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ImageDisplayTemplateSelectorController extends GetxController {
  List<File> files;
  List<double> aspectRatio;
  double selectedAspectRatio;
  String templateType = "vertical";

  initialise() {
    Set _temp = aspectRatio.toSet();
    print(_temp);
    if (_temp.length == 1) {
      selectedAspectRatio = aspectRatio[0];
    } else {
      aspectRatio.sort();
      selectedAspectRatio = aspectRatio.first;
    }
  }

  Widget getTemplate(String templateType) {
    if (files.length == 1) {
      return SingleImageDisplayTemplate(
        imageFile: files[0],
        aspectRatio: aspectRatio[0],
      );
    } else {
      switch (templateType.toLowerCase()) {
        case "imagecarousel":
          print("object");
          return ImageCarouselDisplayTemplate(
            files: files,
            aspectRatio: selectedAspectRatio,
          );
          break;
        case "vertical":
          if (files.length == 2) {
            return DoubleImageVerticalDisplayTemplate(
              files: files,
            );
          } else {
            return MultiImageVerticalDisplayTemplate(
              files: files,
            );
          }

          break;
        case "horizontal":
          if (files.length == 2) {
            return DoubleImageHorizontalDisplayTemplate(
              files: files,
            );
          } else {
            return MultiImageHorizontalDisplayTemplate(
              files: files,
            );
          }

          break;
        default:
      }
    }
  }

  updateTemplate(String template) {
    templateType = template;
    update();
  }

  //get back to addpostpagescreen with data
  getBack() {
    Get.back(result: {
      "files": files,
      "templateType": templateType,
      "aspectRatio": selectedAspectRatio
    });
  }
}
