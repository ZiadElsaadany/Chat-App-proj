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


}
