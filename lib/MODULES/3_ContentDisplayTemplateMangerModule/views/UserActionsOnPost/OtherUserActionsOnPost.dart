import 'package:flutter/material.dart';

class OtherUserActionsOnPost extends StatelessWidget {
  final String postUserId;
  final String postId;

  const OtherUserActionsOnPost({Key key, @required this.postUserId,@required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton<TextButton>(
        elevation: 0.0,
        padding: EdgeInsets.all(2.0),
        itemBuilder: (context) {
          return [
            PopupMenuItem<TextButton>(
                child: TextButton(
              onPressed: () {
                print("okay");
              },
              child: Text('Block User'),
            )),
            PopupMenuItem<TextButton>(
                child: TextButton(
              onPressed: () {
                print("okay");
              },
              child: Text('Unfollow'),
            )),
            PopupMenuItem<TextButton>(
                child: TextButton(
              onPressed: () {
                print("okay");
              },
              child: Text('Report'),
            )),
          ];
        },
      ),
    );
  }
}
