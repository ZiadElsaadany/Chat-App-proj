import 'dart:io';
import 'dart:math';

import 'package:amir_chhat_app/core/extension/context_extention.dart';
import 'package:amir_chhat_app/core/extension/size_extension.dart';
import 'package:amir_chhat_app/model/send_message_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/shared/empty_widget.dart';
import '../../../core/shared/loading_widget.dart';
import '../../../model/message_model.dart';
import '../../../providers/chat_provider.dart';
import 'widgets/text_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MessageModel model;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<ChatProvider>(context, listen: false).singleChatListener(
        widget.model.id,
      );
      await Provider.of<ChatProvider>(context, listen: false).resetUnReadCount(
        widget.model.id,
      );
    });
  }

  final TextEditingController messageController = TextEditingController();

  File? imageFile;

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = const Uuid().v1();

    var re =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var upload = await re.putFile(imageFile!).catchError((error) {});


    String imageUrl = await upload.ref.getDownloadURL();

   if(context.mounted
    ){
     Provider.of<ChatProvider>(context,listen: false).sendMessage(
         MessageModel(message: imageUrl,
           date: DateTime.now().toIso8601String(),
           image: widget.model.image,
           name: widget.model.name,
           unReadCount: 0,
           type: MessageType.image,
           id: widget.model.id,
         ));
   }
    debugPrint(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          await provider.resetUnReadCount(
            widget.model.id,
          );
          if (provider.chatEmoji == true) {
            provider.changeChatEmojiPicker(false);
          }
          return true;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            provider.changeChatEmojiPicker(false);
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 234, 248, 255),
            appBar: AppBar(
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () async {
                  context.pop();

                  await provider.resetUnReadCount(
                    widget.model.id,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackColor,
                ),
              ),
              centerTitle: true,
              titleSpacing: 0,
              title: Text(
                widget.model.name,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: provider.messagesMap[widget.model.id] != null &&
                          provider.messagesMap[widget.model.id]!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: ListView.separated(
                            reverse: true,
                            itemBuilder: (ctx, index) =>

                                TextMessageWidget(
                              model: provider.messagesMap[widget.model.id]![
                                  provider.messagesMap[widget.model.id]!
                                          .length -
                                      1 -
                                      index],
                            ),
                            separatorBuilder: (ctx, index) => const SizedBox(
                              height: 12,
                            ),
                            itemCount:
                                provider.messagesMap[widget.model.id]!.length,
                          ),
                        )
                      : Center(
                          child: provider.getMessagesLoading
                              ? const LoadingWidget()
                              : const EmptyWidget(),
                        ),
                ),
                Column(
                  children: [
                    Container(
                      height: 80,
                      color: AppColors.greyColor1,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              provider
                                  .changeChatEmojiPicker(!provider.chatEmoji);
                            },
                            icon: Icon(Icons.emoji_emotions_outlined),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: EdgeInsets.only(
                                left: 6,
                                right: 6,
                              ),
                              child: TextField(
                                onTap: () {
                                  provider.changeChatEmojiPicker(false);
                                },
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                scrollPadding: const EdgeInsets.all(0),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: Icon(Icons.photo),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 12,
                                  ),
                                  hintText: "Write a message",
                                  contentPadding: const EdgeInsets.all(10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                            onPressed: () async {
                              if (messageController.text.isNotEmpty) {
                                await provider
                                    .sendMessage(
                                  MessageModel(
                                    message: messageController.text,
                                    date: DateTime.now().toIso8601String(),
                                    image: widget.model.image,
                                    name: widget.model.name,
                                    unReadCount: 0,
                                    type: MessageType.text,
                                    id: widget.model.id,
                                  ),
                                )
                                    .then((value) {
                                  FocusScope.of(context).unfocus();
                                  provider.changeChatEmojiPicker(false);
                                });
                              }
                            },
                            child: const Icon(
                              Icons.send,
                              color: AppColors.blueColor1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (provider.chatEmoji)
                      SizedBox(
                        height: 35.appHeight(context),
                        child: EmojiPicker(
                          textEditingController: messageController,
                          config: Config(
                            bgColor: const Color.fromARGB(255, 234, 248, 255),
                            columns: 7,
                            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                          ),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
