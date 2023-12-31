import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.color = AppColors.yellowColor1})
      : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
