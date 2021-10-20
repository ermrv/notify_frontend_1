import 'package:flutter/material.dart';

class TextDescriptionTemplate extends StatelessWidget {
  final String description;
  final List tags;
  final List mentions;

  const TextDescriptionTemplate(
      {Key key,
      @required this.description,
      @required this.tags,
      @required this.mentions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text.rich(_postDiscriptionParser(tags, mentions, description)),
    );
  }

  TextSpan _postDiscriptionParser(
      List tags, List mentions, String description) {
    List words = description.split(" ").toList();
    return TextSpan(children: [
      for (String word in words) _getWordStyle(word),
    ]);
  }

  _getWordStyle(String word) {
    String _trimmedWord = word.trim();
    List _characters = _trimmedWord.characters.toList();
    if (_characters[0] == "@") {
      return TextSpan(text: "$word");
    } else if (_characters[0] == "#") {
      ///return the tags type text
    } else {
      ///return normal text
    }
  }
}
