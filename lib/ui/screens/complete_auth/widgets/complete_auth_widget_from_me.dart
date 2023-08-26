import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CompleteAuthWidgetFromMe extends StatelessWidget {
  const CompleteAuthWidgetFromMe({Key? key, required this.text, required this.widget}) : super(key: key);


  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10
      ),
      decoration:  BoxDecoration(

          color: AppColors.yellowColor1.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
             topEnd:Radius.circular(20) ,
            topStart:Radius.circular(20) ,
            bottomEnd: Radius.circular(0) ,
            bottomStart: Radius.circular(20)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,

        children: [
          widget,
          const SizedBox(
            width: 10,
          ),
          Text(text, style: const TextStyle(
              color: AppColors.whiteColor,
            fontSize: 16
          ),),


        ],
      ),
    );
  }
}
