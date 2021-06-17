import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/AddPostModule/SingleImagePickerModule/controllers/SingleImagePickerController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:photo_manager/photo_manager.dart';

class SingleImagePicker extends StatelessWidget {
  ///profile pic ,coverPic,multiImagePost,singleImagePost
  final String intendedFor;
  final singleImagePickerController = Get.put(SingleImagePickerControler());

  SingleImagePicker({Key key, this.intendedFor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleImagePickerControler>(
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: controller.albums.length == 0
                    ? Container()
                    : DropdownButton(
                        hint: Container(
                            width: screenWidth - 70.0,
                            child: Text(controller.value.toString(),
                                overflow: TextOverflow.ellipsis)),
                        items: controller.albums
                            .map(
                              (e) => DropdownMenuItem(
                                  onTap: () {
                                    int index = controller.albums.indexOf(e);
                                    controller.getAssets(
                                        index, e.assetCount, e.name);
                                  },
                                  value: e.name,
                                  child: Container(
                                    width: screenWidth - 70.0,
                                    child: Text(
                                      e.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                            )
                            .toList(),
                        onChanged: (value) {},
                      ),
              ),
              body: controller.imageAssets.length == 0
                  ? Container(
                      child: Center(
                        child: SpinKitThreeBounce(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : GridView.builder(
                      itemCount: controller.imageAssets.length,
                      itemBuilder: (context, index) {
                        return _GridImageElement(
                          intendedFor: intendedFor,
                          element: controller.imageAssets[index],
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                    ),
            ));
  }
}

class _GridImageElement extends StatefulWidget {
  final AssetEntity element;
  final String intendedFor;

  const _GridImageElement(
      {Key key, @required this.element, @required this.intendedFor})
      : super(key: key);

  @override
  __GridImageElementState createState() => __GridImageElementState();
}

class __GridImageElementState extends State<_GridImageElement> {
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.element.thumbDataWithSize(200, 200),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () async {
                await widget.element.file.then((value) {
                  Get.back(result: value);
                  return value;
                });
              },
              child: Image.memory(
                snapshot.data,
                fit: BoxFit.cover,
              ),
            );
          }
          return Container();
        });
  }
}
