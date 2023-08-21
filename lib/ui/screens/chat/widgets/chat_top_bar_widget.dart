import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';


class ChatTopBarWidget extends StatelessWidget {
  const ChatTopBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Image.asset(
              AppImages.appLogo,
              height: 100,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 20,
              child: Text(
                "Inbox",
                style: const TextStyle(
                  color: AppColors.blueColor1,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
