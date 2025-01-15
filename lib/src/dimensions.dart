import 'package:flutter/material.dart';

class Dimensions {
  
  static late double screenHeight;
  static late double screenWidth;

  static late double baseWidth;
  static late double baseHeight;

  static void init (BuildContext context, {double? height, double? width}){
    final mediaQuery = MediaQuery.of(context).size;
    screenHeight = mediaQuery.height;
    screenWidth = mediaQuery.width;
    baseHeight = height ?? 812;
    baseWidth = width ?? 380;


  }

  static double width (double w){
    return screenWidth * (w / baseWidth) ;
  }

  static double height (double h){
    return screenHeight * (h / baseHeight) ;
  }

  static double size(double sizeFactor) {
    double baseAverageDimension = (baseWidth + baseHeight) / 2;
    double currentAverageDimension = (screenWidth + screenHeight) / 2;
    return currentAverageDimension * (sizeFactor / baseAverageDimension); 
  }

}