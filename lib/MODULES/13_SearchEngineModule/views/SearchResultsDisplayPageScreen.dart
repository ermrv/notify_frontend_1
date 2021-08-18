import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:flutter/material.dart';


class SearchResultsDisplayPageScreen extends StatelessWidget {
  final String searchedKeywords;

  const SearchResultsDisplayPageScreen({Key key, this.searchedKeywords}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 40.0,
          width: screenWidth,
          child: TextFormField(
            initialValue: searchedKeywords,
            readOnly: true,
          ),
        ),
      ),
      
    );
  }
}