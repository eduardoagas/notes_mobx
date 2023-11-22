import 'package:flutter/material.dart';

import '../utils/get_screen_size.dart';

//781,09
//392,72

class Dimensions {
  static Size size = GetScreenSize().getScreenSize();

  static double screenHeight = size.height;
  static double screenWidth = size.width;

  static EdgeInsetsGeometry edgeInsets8 = EdgeInsets.only(
      top: Dimensions.height8,
      bottom: Dimensions.height8,
      left: Dimensions.width8,
      right: Dimensions.width8);

  static double height1dot5 = screenHeight / 520.68;
  static double height2 = screenHeight / 390.54;
  static double height5 = screenHeight / 156.21;
  static double height7 = screenHeight / 111.58;
  static double height8 = screenHeight / 97.63;
  static double height10 = screenHeight / 78.10;
  static double height12 = screenHeight / 75.09;
  static double height13 = screenHeight / 60.08;
  static double height15 = screenHeight / 52.07;
  static double height16 = screenHeight / 48.81;
  static double height20 = screenHeight / 39.05;
  static double height24 = screenHeight / 32.54;
  static double height30 = screenHeight / 26.03;
  static double height40 = screenHeight / 19.52;
  static double height44 = screenHeight / 17.75;
  static double height50 = screenHeight / 15.62;
  static double height55 = screenHeight / 14.20;
  static double height57 = screenHeight / 13.70;
  static double height60 = screenHeight / 13.01;
  static double height70 = screenHeight / 11.15;
  static double height80 = screenHeight / 9.76;
  static double height90 = screenHeight / 8.67;
  static double height150 = screenHeight / 5.20;
  static double height160 = screenHeight / 4.88;
  static double height180 = screenHeight / 4.33;
  static double height200 = screenHeight / 3.81;
  static double height205 = screenHeight / 3.90;
  static double height212 = screenHeight / 3.68;

  static double height450 = screenHeight / 1.73;

  static double width2 = screenWidth / 186.36;
  static double width3 = screenWidth / 130.9;
  static double width5 = screenWidth / 78.54;
  static double width8 = screenWidth / 49.09;
  static double width10 = screenWidth / 39.27;
  static double width12 = screenWidth / 32.72;
  static double width15 = screenWidth / 26.18;
  static double width16 = screenWidth / 24.54;
  static double width18 = screenWidth / 21.81;
  static double width20 = screenWidth / 19.63;
  static double width24 = screenWidth / 16.36;
  static double width70 = screenWidth / 5.61;
  static double width130 = screenWidth / 3.01;
  static double width150 = screenWidth / 2.61;
  static double width180 = screenWidth / 2.18;
  static double width210 = screenWidth / 1.87;

  static double font4 = screenHeight / 195.27;
  static double font6 = screenHeight / 130.18;
  static double font12 = screenHeight / 75.09;
  static double font16 = screenHeight / 48.81;
  static double font14 = screenHeight / 55.79;
  static double font17 = screenHeight / 45.94;
  static double font18 = screenHeight / 43.19;
  static double font19 = screenHeight / 41.11;
  static double font20 = screenHeight / 39.05;
  static double font24 = screenHeight / 32.54;
  static double font32 = screenHeight / 24.40;
}
