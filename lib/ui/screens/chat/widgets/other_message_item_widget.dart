import 'package:amir_chhat_app/core/extension/size_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../model/message_model.dart';
import '../show_image_screen.dart';

class OtherMessageItemWidget extends StatelessWidget {
  const OtherMessageItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 60.appWidth(context),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: const BoxDecoration(
          color: AppColors.greyColor1,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          ),
        ),
        child:  model.type == MessageType.image ? Container(
          height: 25.appHeight(context),
          width: 100.appWidth(context),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),

          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ShowImage(
                  imageUrl:model.message,
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.centerRight,
              height: 25.appHeight(context),
              width: 100.appWidth(context)/2,
              decoration: BoxDecoration(border: Border.all()),
              child:model.message != ""
                  ? CachedNetworkImage(imageUrl: model.message)
                  : const CircularProgressIndicator(),
            ),
          ),
        )  :  Text(
          model.message,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
