import 'package:amir_chhat_app/core/extension/context_extention.dart';
import 'package:amir_chhat_app/core/extension/size_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared/network_image_widget.dart';
import '../../../../model/message_model.dart';
import '../chat_screen.dart';


class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      onTap: () {
        context.push(
          ChatScreen(
            model: model,
          ),
        );
      },
      child: SizedBox(
        width: 100.appWidth(context),
        height: 50,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              height: 50,
              width: 50,
              child: NetworkImageWidget(
                imageUrl: model.image,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 50.appWidth(context),
                    child: Text(
                      model.name,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: 50.appWidth(context),
                    child: Text(
                      model.message,
                      style: const TextStyle(
                        color: AppColors.greyColor2,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (model.unReadCount > 0)
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.redColor),
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(4),
                child: Text(
                  model.unReadCount.toString(),
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
