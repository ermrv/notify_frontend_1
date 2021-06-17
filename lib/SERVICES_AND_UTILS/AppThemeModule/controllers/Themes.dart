
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class Themes {
  static ThemeData ltheme = ThemeData.raw(
      visualDensity:VisualDensity.adaptivePlatformDensity,
      primaryColor:Colors.blue[800],
      primaryColorBrightness:Brightness.dark,
      primaryColorLight: Colors.blue,
      primaryColorDark: Colors.blue[900],
      canvasColor: Colors.white,
      shadowColor: Colors.grey[100],
      accentColor: Colors.grey,
      accentColorBrightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Colors.white,
      cardColor: Colors.white,
      dividerColor: Colors.grey,
      focusColor: Colors.blue[300],
      hoverColor: Colors.blue[500],
      highlightColor: Colors.blue[500],
      splashColor: Colors.blue[500],
      splashFactory:InkSplash.splashFactory,
      selectedRowColor: Colors.white,
      unselectedWidgetColor: Colors.white,
      disabledColor: Colors.white,
      buttonTheme: ButtonThemeData(),
      buttonColor: Colors.blue,
      toggleButtonsTheme:ToggleButtonsThemeData(),
      secondaryHeaderColor: Colors.blue,
      textSelectionColor: Colors.blue,
      cursorColor: Colors.blue,
      textSelectionHandleColor: Colors.blue,
      backgroundColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      indicatorColor: Colors.blue,
      hintColor: Colors.grey,
      errorColor: Colors.red,
      toggleableActiveColor: Colors.blue,
      textTheme: TextTheme(),
      primaryTextTheme: TextTheme(),
      accentTextTheme: TextTheme(),
      inputDecorationTheme: InputDecorationTheme(),
      iconTheme: IconThemeData(color: Colors.blue),
      primaryIconTheme: IconThemeData(color: Colors.blue),
      accentIconTheme: IconThemeData(color: Colors.blue),
      sliderTheme:SliderThemeData(),
      tabBarTheme: TabBarTheme(),
      tooltipTheme: TooltipThemeData(),
      cardTheme: CardTheme(),
      chipTheme: ChipThemeData.fromDefaults(secondaryColor: Colors.white, labelStyle: TextStyle()),
      platform: TargetPlatform.android,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      applyElevationOverlayColor: false,
      pageTransitionsTheme: PageTransitionsTheme(),
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      scrollbarTheme: ScrollbarThemeData(),
      bottomAppBarTheme: BottomAppBarTheme(),
      colorScheme:ColorScheme.light(),
      dialogTheme: DialogTheme(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(),
      navigationRailTheme: NavigationRailThemeData(),
      typography: Typography.material2018(),
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(),
      snackBarTheme: SnackBarThemeData(),
      bottomSheetTheme:BottomSheetThemeData(),
      popupMenuTheme: PopupMenuThemeData(),
      bannerTheme: MaterialBannerThemeData(),
      dividerTheme: DividerThemeData(),
      buttonBarTheme: ButtonBarThemeData(),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(),
      timePickerTheme: TimePickerThemeData(),
      textButtonTheme: TextButtonThemeData(),
      elevatedButtonTheme: ElevatedButtonThemeData(),
      outlinedButtonTheme: OutlinedButtonThemeData(),
      textSelectionTheme: TextSelectionThemeData(),
      dataTableTheme: DataTableThemeData(),
      checkboxTheme: CheckboxThemeData(),
      radioTheme: RadioThemeData(),
      switchTheme: SwitchThemeData(),
      fixTextFieldOutlineLabel:false,
      useTextSelectionTheme: true);
  //light theme data
  static ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      cardColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue[800]),
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          brightness: Brightness.light,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.light)));

  //dark theme data
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
        brightness: Brightness.dark,
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
