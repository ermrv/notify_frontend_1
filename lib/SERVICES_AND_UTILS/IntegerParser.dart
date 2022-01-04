import 'package:flutter/material.dart';

String integerParser(int integer) {
  if (integer <= 999) {
    return integer.toString();
  } else if (integer > 999 && integer <= 99999) {
    return "${(integer / 1000).toStringAsFixed(1).toString()}k";
  }else if(integer > 99999 && integer <= 9999999){
    return "${(integer / 100000).toStringAsFixed(1).toString()}L";
  }else{
    return "${(integer / 10000000).toStringAsFixed(1).toString()}Cr";
  }
}
