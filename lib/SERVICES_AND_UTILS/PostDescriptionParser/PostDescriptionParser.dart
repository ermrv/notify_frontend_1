import 'package:flutter/material.dart';

postDiscriptionParser(List tags, List mentions, String description) {
  List words = description.split(" ").toList();
  for (String word in words) {
    String _trimmedWord = word.trim();
    List _characters = _trimmedWord.characters.toList();
    if(_characters[0]=="@"){
      ///return the mentions type text
    }else if(_characters[0]=="#"){
      ///return the tags type text
    }else{
      ///return normal text
    }
  }
}
