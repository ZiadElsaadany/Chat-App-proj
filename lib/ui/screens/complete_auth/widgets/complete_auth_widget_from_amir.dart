import 'package:amir_chhat_app/core/constants/app_colors.dart';
import 'package:amir_chhat_app/core/constants/app_images.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';


class CompleteAuthWidgetFromAmir extends StatelessWidget {
  const CompleteAuthWidgetFromAmir({Key? key, required this.text, required this.widget}) : super(key: key);
  final String text;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          height: 50,
          width: 50,
          child:Image.asset(AppImages.appLogo)
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),

            decoration: BoxDecoration(
              color: AppColors.greyColor2.withOpacity(0.5),
               borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
              
                Expanded(
                  child:
            SizedBox(
            width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 15.0,
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(text)
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            )


                  // Text(text, style: const TextStyle(
                  //   color: AppColors.whiteColor,
                  //   fontSize: 15
                  // ),),
                ),
                const SizedBox(
                  width: 5,
                ),
                widget,
              ],
            ),
          ),
        ),



      ],
    );
  }
}
