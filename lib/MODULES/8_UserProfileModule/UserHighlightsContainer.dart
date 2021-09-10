import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';

class PrimaryUserHighlightsContainer extends StatefulWidget {
  @override
  _PrimaryUserHighlightsContainerState createState() =>
      _PrimaryUserHighlightsContainerState();
}

class _PrimaryUserHighlightsContainerState
    extends State<PrimaryUserHighlightsContainer>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  List highlights = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0, bottom: 5.0),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 8.0, top: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Highlights",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            ),
          ),
          Container(
            height: 80.0,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i in highlights)
                  _Template(
                    data: i,
                  ),
                _AddNewHighlights(),
                for (var i = 0; i < 5 - highlights.length; i++)
                  DummyHighlights()
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userHighlights, {}, userToken);
    if (response == "error") {
      print("error occured");
    } else {
      if (this.mounted) {
        setState(() {
          // highlights.addAll(response);
        });
      }
    }
  }
}

class _Template extends StatelessWidget {
  final data;

  const _Template({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
    );
  }
}

//add new highlights playlist
class _AddNewHighlights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
      child: Center(
        child: Icon(Icons.add),
      ),
    );
  }
}

class DummyHighlights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
    );
  }
}
