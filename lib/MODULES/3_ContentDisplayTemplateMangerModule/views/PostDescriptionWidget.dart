import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/CommonPostDisplayPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDescriptionWidget extends StatelessWidget {
  final String postType;
  final List tags;
  final List mentions;
  final description;
  final displayFullText;

  const PostDescriptionWidget(
      {Key key,
      @required this.tags,
      @required this.mentions,
      @required this.description,
      @required this.postType,
      @required this.displayFullText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _postDiscriptionParser(tags, mentions, description),
    );
  }

  Wrap _postDiscriptionParser(List tags, List mentions, String description) {
    double fontsize = 16.0;
    List words = description.split(RegExp(" ")).toList();
    List wordsToDisplay;
    //selecting font size
    if (postType != "pollPost") {
      fontsize = words.length <= 15
          ? 22.0
          : words.length <= 30
              ? 19.0
              : 16.0;
    }
    //selecting words to display
    if (displayFullText) {
      wordsToDisplay = words;
    } else if (words.length >= 60) {
      wordsToDisplay = words.getRange(0, 59).toList();
    } else {
      wordsToDisplay = words;
    }

    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        for (String word in wordsToDisplay) _getWordStyle(word, fontsize),
        displayFullText?Container():words.length>=60?Text(".....more",style: TextStyle(color:Colors.blue,fontSize: 16.0)):Container()
      ],
    );
  }

  _getWordStyle(String word, double fontSize) {
    String trimmedWord = word.trim();
    List characters = trimmedWord.characters.toList();
    if (characters[0] == "@") {
      return Text(
        word,
        style: TextStyle(color: Colors.blue, fontSize: fontSize),
      );
    } else if (characters[0] == "#") {
      return GestureDetector(
        onTap: () {
          // Get.to(()=>CommonPostDisplayPageScreen(apiUrl: apiUrl, apiData: apiData));
        },
        child: Text(word,
            style: TextStyle(color: Colors.blue, fontSize: fontSize)),
      );
    } else {
      return Text(word + " ", style: TextStyle(fontSize: fontSize));
    }
  }
}
