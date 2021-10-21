import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class Themes {
  //.....................................light theme data..............................
  //.................................................................................
  static ThemeData lightTheme = ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      brightness: Brightness.dark,
      //input border decoration theme
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 0.8)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 0.5))),
      //appbar theme
      appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.blue),
          titleTextStyle: TextStyle(
              color: Colors.blue,
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic)),
      secondaryHeaderColor: Colors.blue,
      indicatorColor: Colors.blue,
      
      buttonTheme: ButtonThemeData(
       
        
      ),
      accentColor: Colors.black,
      //icontheme
      iconTheme: IconThemeData(color: Colors.blue,size: 18.0),
      //textbutton theme
      //
      //
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            side: MaterialStateProperty.resolveWith(
                (states) => BorderSide(color: Colors.blue[300], width: 0.5)),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.blue[100]),
            padding: MaterialStateProperty.resolveWith((states) =>
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0)),
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(50.0, 5.0)),
            textStyle: MaterialStateProperty.resolveWith((states) =>
                TextStyle(color: Colors.blue, fontWeight: FontWeight.w700))),
      ),

      //elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.blue[100]),
            padding: MaterialStateProperty.resolveWith((states) =>
                EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0)),
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(50.0, 5.0)),
            shape: MaterialStateProperty.resolveWith((states) =>
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            elevation: MaterialStateProperty.resolveWith((states) => 0.5),
            textStyle: MaterialStateProperty.resolveWith((states) =>
                TextStyle(color: Colors.blue, fontWeight: FontWeight.w700))),
      ),
      );

  //.................................dark theme data...............................
  //................................................................................
  static ThemeData darkTheme = ThemeData.dark().copyWith(
      backgroundColor: Colors.black,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.black,
      brightness: Brightness.dark,
      //input border decoration theme
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.8)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.5))),
      //appbar theme
      appBarTheme: AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light),
      ),
      accentColor: Colors.white,
      indicatorColor: Colors.white,
      buttonColor: Colors.grey[800],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.grey[800],
      ),
      //textbutton theme
      //
      //
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            side: MaterialStateProperty.resolveWith(
                (states) => BorderSide(color: Colors.grey[600], width: 0.5)),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.grey[800]),
            padding: MaterialStateProperty.resolveWith((states) =>
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0)),
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(50.0, 5.0)),
            textStyle: MaterialStateProperty.resolveWith((states) =>
                TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
      ),

      //elevated button theme
      //
      //
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.grey[800]),
            padding: MaterialStateProperty.resolveWith((states) =>
                EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0)),
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(50.0, 5.0)),
            shape: MaterialStateProperty.resolveWith((states) =>
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            elevation: MaterialStateProperty.resolveWith((states) => 0.5),
            textStyle: MaterialStateProperty.resolveWith((states) =>
                TextStyle(color: Colors.blue, fontWeight: FontWeight.w700))),
      ));
}
