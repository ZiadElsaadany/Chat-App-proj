import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../constants/app_constants.dart';


class AppHelper {


  static String getUserId() {
    return Hive.box(AppConstants.myBox).get(
      AppConstants.userIdKey,
      defaultValue: '',
    );
  }
  static Map getUserModel() {
    return Hive.box(AppConstants.myBox).get(
      AppConstants.userDataKey,
      defaultValue: {},
    );
  }

  static void  showSnack( {
   required BuildContext context,required String text
} ) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        duration: const Duration(milliseconds: 500),
        content: Text(text)));
  }

}
