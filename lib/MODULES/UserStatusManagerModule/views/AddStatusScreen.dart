import 'package:MediaPlus/MODULES/UserStatusManagerModule/views/StatusImagesGridView.dart';
import 'package:MediaPlus/MODULES/UserStatusManagerModule/views/StatusVideoGridView.dart';
import 'package:flutter/material.dart';

class AddStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            elevation: 0.1,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  text: "Images",
                ),
                Tab(
                  text: "Videos",
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50.0),
        ),
        body: TabBarView(
            children: [StatusImagesGridView(), StatusVideoGridView()]),
      ),
    );
  }
}
