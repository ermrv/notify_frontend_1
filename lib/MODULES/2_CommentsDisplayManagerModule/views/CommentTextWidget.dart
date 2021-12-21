import 'package:flutter/material.dart';

class CommentTextWidget extends StatelessWidget {
  final List tags;
  final List mentions;
  final commentText;

  const CommentTextWidget({
    Key key,
    @required this.tags,
    @required this.mentions,
    @required this.commentText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _commentTextParser(tags, mentions, commentText),
    );
  }

  Wrap _commentTextParser(List tags, List mentions, String description) {
    double fontsize = 16.0;
    List words = description.split(" ").toList();

    return Wrap(
      children: [
        for (String word in words) _getWordStyle(word, fontsize),
      ],
    );
  }

  _getWordStyle(String word, double fontSize) {
    String trimmedWord = word.trim();
    List characters = trimmedWord.characters.toList();
    return Text(word + " ", style: TextStyle(fontSize: fontSize));
    // if (characters[0] == "@") {
    //   return Text(
    //     word,
    //     style: TextStyle(color: Colors.blue, fontSize: fontSize),
    //   );
    // } else if (characters[0] == "#") {
    //   return GestureDetector(
    //     onTap: () {
    //       // Get.to(()=>CommonPostDisplayPageScreen(apiUrl: apiUrl, apiData: apiData));
    //     },
    //     child: Text(word,
    //         style: TextStyle(color: Colors.blue, fontSize: fontSize)),
    //   );
    // } else {
    //   return Text(word + " ", style: TextStyle(fontSize: fontSize));
    // }
  }
}
