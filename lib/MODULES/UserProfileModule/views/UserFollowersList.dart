
import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// stlful widget--Listview which contains all the list of followers
class PrimaryUserFollowersList extends StatefulWidget {
  @override
  _PrimaryUserFollowersListState createState() => _PrimaryUserFollowersListState();
}

class _PrimaryUserFollowersListState extends State<PrimaryUserFollowersList> {
  List _data = [];
  bool requestProcessed = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Text(
          "Followers",
        ),
      ),
      body: requestProcessed
          ? _data.length == 0
              ? Center(
                  child: Text("No Followers!"),
                )
              : ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return _Template(
                      data: _data[index],
                    );
                  },
                )
          : Center(
              child: SpinKitThreeBounce(
                size: 22.0,
                color: Colors.blue,
              ),
            ),
    );
  }

  _getData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userFollowers, {}, userToken.toString());
    if (response == "error") {
      print("some error occured");
    } else {
      if (this.mounted) {
        setState(() {
          requestProcessed = true;
          _data.addAll(response);
        });
      }
    }
  }
}

///stfull widget for handling the user followback/ actions
///
///contains profile image ,user id ,name and action button
class _Template extends StatefulWidget {
  final data;

  const _Template({Key key, this.data}) : super(key: key);
  @override
  __TemplateState createState() => __TemplateState();
}

class __TemplateState extends State<_Template> {
  String _buttonText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25.0,
        ),
        title: Text("Name of User"),
        subtitle: Text("userName"),
        trailing: RaisedButton(
            child: Text("Follow Back"),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            onPressed: () {}),
      ),
    );
  }
}
