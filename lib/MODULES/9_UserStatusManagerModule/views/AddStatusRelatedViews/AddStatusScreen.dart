import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/9_UserStatusManagerModule/controllers/AddStatusRelatedControllers/AddStatusPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class AddStatusScreen extends StatelessWidget {
  final addStatusPageController = Get.put(AddStatusPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStatusPageController>(
      builder: (controller) => controller.assets.length == 0
          ? Container(
              child: Center(
                child: SpinKitThreeBounce(
                  size: 30.0,
                  color: Colors.blue,
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: controller.albums.length == 0
                    ? Container()
                    : DropdownButton(
                        hint: Container(
                            width: screenWidth * 0.6,
                            child: Text(
                              controller.value.toString(),
                              overflow: TextOverflow.ellipsis,
                            )),
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
                                    child: Container(
                                        width: screenWidth * 0.6,
                                        child: Text(
                                          e.name.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  )),
                            )
                            .toList(),
                        onChanged: (value) {},
                      ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    height: 30.0,
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Container(
                        height: 21.0,
                        alignment: Alignment.center,
                        child: Obx(() => Text("(" +
                            controller.filesSelectedCount.value.toString() +
                            ") " +
                            "Next")),
                      ),
                      onPressed: () {
                        controller.submitHandler();
                      },
                    ),
                  ),
                ],
              ),
              body: Container(
                child: GridView.builder(
                  itemCount: controller.assets.length,
                  itemBuilder: (context, index) {
                    return _GridElement(
                      controller: controller,
                      element: controller.assets[index],
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    crossAxisCount: 3,
                  ),
                ),
              )),
    );
  }
}

class _GridElement extends StatelessWidget {
  final AssetEntity element;
  final AddStatusPageController controller;

  const _GridElement({Key key, this.element, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: element.thumbDataWithSize(200, 200),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return Container(
            child: GestureDetector(
              onTap: () {
                controller.handleOnTap(element);
              },
              onLongPress: () {
                controller.handleLongPress(element);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(
                    snapshot.data,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5.0,
                    right: 5.0,
                    child: element.type == AssetType.video
                        ? Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.black26, shape: BoxShape.circle),
                            child: Icon(
                              Feather.video,
                              size: 18.0,
                            ),
                          )
                        : Container(),
                  ),
                  Positioned(
                      right: 5.0,
                      bottom: 5.0,
                      child: Obx(
                          () => controller.selectedassetEntity.contains(element)
                              ? Container(
                                  height: 20.0,
                                  width: 20.0,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                  ),
                                )
                              : Container())),
                ],
              ),
            ),
          );
        return Container();
      },
    );
  }
}
