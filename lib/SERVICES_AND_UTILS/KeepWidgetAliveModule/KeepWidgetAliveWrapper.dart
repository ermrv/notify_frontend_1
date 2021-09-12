import 'package:flutter/material.dart';

class KeepWidgetAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepWidgetAliveWrapper({Key key, this.child}) : super(key: key);

  @override
  __KeepWidgetAliveWrapperState createState() => __KeepWidgetAliveWrapperState();
}

class __KeepWidgetAliveWrapperState extends State<KeepWidgetAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}