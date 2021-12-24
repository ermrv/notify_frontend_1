import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/CommonPostDisplayPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

class PostDescriptionWidget extends StatelessWidget {
  final String postType;
  final List tags;
  final List mentions;
  final description;
  final bool displayFullText;

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
    return _getParsedText(description, context);
  }

  Container _getParsedText(String text, BuildContext context) {
    double fontsize = 16.0;
    List words = text.split(RegExp(" ")).toList();
    if (postType != "pollPost") {
      fontsize = words.length <= 20
          ? 22.0
          : words.length <= 50
              ? 19.0
              : 16.0;
    }
    return Container(
        child: ParsedText(
      maxLines: displayFullText ? 1000 : 15,
      overflow: TextOverflow.ellipsis,
      text: description,
      style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
          fontSize: fontsize),
      parse: <MatchText>[
        //for # tags
        MatchText(
          pattern: r"\B#+([\w]+)\b",
          style: TextStyle(
            color: Colors.blue,
            fontSize: fontsize,
          ),
          onTap: (tag) {
            Get.to(() => CommonPostDisplayPageScreen(
                title: tag.toString(),
                apiUrl: ApiUrlsData.tagRelatedPosts,
                apiData: {"hashtag": tag.toString()}));
          },
          // onLongTap: (url) {
          //   print('long press');
          // },
        ),
        //for mentions
        MatchText(
            pattern: r"\B@+([\w]+)\b",
            style: TextStyle(
              color: Colors.blue,
              fontSize: fontsize,
            ),
            onTap: (mention) {
              String userId;
              try {
                mentions.forEach((element) {
                  if (element["mention"] == mention) {
                    userId = element["userId"].toString();
                    print(userId);
                  } else {
                    userId = null;
                  }
                });
              } catch (e) {
                print(e);
              }
              userId == null
                  ? Get.dialog(AlertDialog(content: Text("User not found")))
                  : Get.dialog(AlertDialog(content: Text(mention)));
            }),
        //for emails
        MatchText(
          type: ParsedType.EMAIL,
          style: TextStyle(
            color: Colors.blue,
            fontSize: fontsize,
          ),
          onTap: (url) {
            Get.dialog(AlertDialog(content: Text(url)));
          },
        ),
        //for urls
        MatchText(
            type: ParsedType.URL,
            style: TextStyle(
              color: Colors.blue,
              fontSize: fontsize,
            ),
            onTap: (url) async {
              Get.dialog(AlertDialog(content: Text(url)));
            }),
        //for mobile numbers
        MatchText(
            type: ParsedType.PHONE,
            style: TextStyle(
              color: Colors.blue,
              fontSize: fontsize,
            ),
            onTap: (url) {
              Get.dialog(AlertDialog(content: Text(url)));
            }),
      ],
    ));
  }

  // Wrap _postDiscriptionParser(List tags, List mentions, String description) {
  //   double fontsize = 16.0;
  //   List words = description.split(RegExp(" ")).toList();
  //   List wordsToDisplay;
  //   //selecting font size
  //   if (postType != "pollPost") {
  //     fontsize = words.length <= 20
  //         ? 22.0
  //         : words.length <= 50
  //             ? 19.0
  //             : 16.0;
  //   }
  //   //selecting words to display
  //   if (displayFullText) {
  //     wordsToDisplay = words;
  //   } else if (words.length >= 90) {
  //     wordsToDisplay = words.getRange(0, 89).toList();
  //   } else {
  //     wordsToDisplay = words;
  //   }

  //   return Wrap(
  //     alignment: WrapAlignment.start,
  //     children: [
  //       for (String word in wordsToDisplay) _getWordStyle(word, fontsize),
  //       displayFullText?Container():words.length>=89?Text(".....more",style: TextStyle(color:Colors.blue,fontSize: 16.0)):Container()
  //     ],
  //   );
  // }

  // _getWordStyle(String word, double fontSize) {
  //   String trimmedWord = word.trim();
  //   List characters = trimmedWord.characters.toList();
  //   if (characters[0] == "@") {
  //     return Text(
  //       word,
  //       style: TextStyle(color: Colors.blue, fontSize: fontSize),
  //     );
  //   } else if (characters[0] == "#") {
  //     return GestureDetector(
  //       onTap: () {
  //         // Get.to(()=>CommonPostDisplayPageScreen(apiUrl: apiUrl, apiData: apiData));
  //       },
  //       child: Text(word,
  //           style: TextStyle(color: Colors.blue, fontSize: fontSize)),
  //     );
  //   } else {
  //     return Text(word + " ", style: TextStyle(fontSize: fontSize));
  //   }
  // }
}
