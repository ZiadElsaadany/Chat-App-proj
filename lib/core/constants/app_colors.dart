import 'package:flutter/material.dart';

class AppColors {
  static const Color blueColor1 = Color(0xff3fabf4);
  static const Color blueColor2 = Color(0xff3aced4);
  static const Color greyColor1 = Color(0xffeaeaea);
  static const Color greyColor2 = Colors.grey;
  static const Color whiteColor = Colors.white;
  static const Color white24Color = Colors.white24;
  static const Color white38Color = Colors.white38;
  static const Color white70Color = Colors.white70;
  static const Color blackColor = Colors.black;
  static const Color black12Color = Colors.black12;
  static const Color black38Color = Colors.black38;
  static const Color black87Color = Colors.black87;
  static const Color orangeColor = Colors.orange;
  static const Color redColor = Colors.red;

  static const mainGradient = LinearGradient(
    colors: [
      blueColor1,
      blueColor2,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static final secondGradient = LinearGradient(
    colors: [
      blueColor1.withOpacity(0.8),
      blueColor2.withOpacity(0.6),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Map<int, Color> materialColorMap = {
    50: const Color.fromRGBO(63, 171, 244, .1),
    100: const Color.fromRGBO(63, 171, 244, .2),
    200: const Color.fromRGBO(63, 171, 244, .3),
    300: const Color.fromRGBO(63, 171, 244, .4),
    400: const Color.fromRGBO(63, 171, 244, .5),
    500: const Color.fromRGBO(63, 171, 244, .6),
    600: const Color.fromRGBO(63, 171, 244, .7),
    700: const Color.fromRGBO(63, 171, 244, .8),
    800: const Color.fromRGBO(63, 171, 244, .9),
    900: const Color.fromRGBO(63, 171, 244, 1),
  };

  static MaterialColor baseColor = MaterialColor(
    0xff3fabf4,
    materialColorMap,
  );
}
