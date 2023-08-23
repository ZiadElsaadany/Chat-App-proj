import 'package:amir_chhat_app/core/extension/size_extension.dart';
import 'package:amir_chhat_app/ui/screens/chat/widgets/voice_message_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../model/message_model.dart';
import '../show_image_screen.dart';


class MyMessageItemWidget extends StatelessWidget {
  const MyMessageItemWidget({
    Key? key, required this.model, required this.audioPlayer, required this.record,
  }) : super(key: key);
final MessageModel model;
final AudioPlayer audioPlayer;
final Record record; 
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 200,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomStart: Radius.circular(10),
          ),
        ),
        child: model.type == MessageType.image?

        Container(
          alignment: Alignment.centerLeft,

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
              height: 25.appHeight(context),
              width: 100.appWidth(context)/2,
              decoration: BoxDecoration(border: Border.all()),
              child:model.message != ""
                  ? CachedNetworkImage(imageUrl: model.message)
                  : const CircularProgressIndicator(),
            ),
          ),
        )
            :  model.type ==MessageType.audio?
        VoiceMessageWidget(messageModel: model)
            : Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration (
            borderRadius: BorderRadiusDirectional.only(
                bottomEnd:   Radius.circular(12),
            bottomStart:Radius.circular(12)  ,
              topEnd:  Radius.circular(0) ,
               topStart:Radius.circular(15)
            ),
            color: AppColors.blueColor1
          ),
              child: Text(
          model.message,
          style:const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
          ),
        ),
            ),
      ),
    );
  }
}
